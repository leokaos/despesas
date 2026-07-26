package org.leo.despesas.dominio.alerta;

import java.util.Optional;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.leo.despesas.dominio.debitavel.Divida;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.infra.util.DataUtil;

@Entity
@Table(name = "alerta_limite_pagamento_divida", schema = "despesas_db")
public class AlertaLimitePagamentoDivida extends Alerta {

	private static final long serialVersionUID = 5906177258449995082L;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "divida_id", nullable = true)
	private Divida divida;

	@Column(name = "dias_antes_de_aviso")
	private int diasAntesDeAviso;

	public AlertaLimitePagamentoDivida() {
		super();
	}

	public Divida getDivida() {
		return divida;
	}

	public void setDivida(Divida divida) {
		this.divida = divida;
	}

	public int getDiasAntesDeAviso() {
		return diasAntesDeAviso;
	}

	public void setDiasAntesDeAviso(int diasAntesDeAviso) {
		this.diasAntesDeAviso = diasAntesDeAviso;
	}

	@Override
	public Optional<Notificacao> gerarNotificacao() {

		if (DataUtil.estaNosProximosDias(divida.getDataLimite(), diasAntesDeAviso)) {

			Notificacao notificacao = new Notificacao();
			notificacao.setAlerta(this);
			notificacao.setExecutado(false);
			notificacao.setTargetDate(divida.getDataLimite());

			return Optional.of(notificacao);
		}

		return Optional.empty();
	}

	@Override
	public String getDescricao() {
		return "Efetuar pagamento de " + this.divida.getDescricao();
	}

}
