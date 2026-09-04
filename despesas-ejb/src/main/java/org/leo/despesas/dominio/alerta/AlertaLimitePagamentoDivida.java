package org.leo.despesas.dominio.alerta;

import static org.leo.despesas.infra.util.DataUtil.estaNosProximosDias;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.leo.despesas.dominio.debitavel.Divida;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.infra.alerta.AlertaProcessorVisitor;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "alerta_limite_pagamento_divida", schema = "despesas_db")
@Getter
@Setter
@NoArgsConstructor
public class AlertaLimitePagamentoDivida extends Alerta {

	private static final long serialVersionUID = 5906177258449995082L;

	@ManyToOne
	@JoinColumn(name = "divida_id", nullable = true)
	private Divida divida;

	@Override
	public Notificacao gerarNotificacao() {

		Notificacao notificacao = new Notificacao();
		notificacao.setAlerta(this);
		notificacao.setExecutado(false);
		notificacao.setTargetDate(divida.getDataLimite());

		return notificacao;
	}

	public boolean isDataLimiteDividaProximosDias() {
		return estaNosProximosDias(divida.getDataLimite(), diasAntesDeAviso);
	}

	@Override
	public String getDescricao() {
		return "Efetuar pagamento de " + this.divida.getDescricao();
	}

	@Override
	public void accept(AlertaProcessorVisitor visitor) {
		visitor.visit(this);
	}

}
