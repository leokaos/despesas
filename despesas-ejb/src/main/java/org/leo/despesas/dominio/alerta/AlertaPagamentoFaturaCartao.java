package org.leo.despesas.dominio.alerta;

import static org.leo.despesas.infra.util.DataUtil.estaNosProximosDias;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.infra.alerta.AlertaProcessorVisitor;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "alerta_pagamento_fatura_cartao", schema = "despesas_db")
@Getter
@Setter
@NoArgsConstructor
public class AlertaPagamentoFaturaCartao extends Alerta {

	private static final long serialVersionUID = -6444085653952299136L;

	@ManyToOne
	@JoinColumn(name = "cartao_credito_id", nullable = true)
	private CartaoCredito cartao;

	@Override
	public Notificacao gerarNotificacao() {

		Notificacao notificacao = new Notificacao();
		notificacao.setAlerta(this);
		notificacao.setExecutado(false);
		notificacao.setTargetDate(LocalDate.now().withDayOfMonth(cartao.getDiaDeVencimento()));

		return notificacao;
	}

	@Override
	public String getDescricao() {
		return "Pagar fatura para " + this.cartao.getDescricao();
	}

	@Override
	public void accept(AlertaProcessorVisitor visitor) {
		visitor.visit(this);
	}

	public boolean isProximaFaturaNosProximosDias() {
		return cartao.isAtivo() && estaNosProximosDias(cartao.getDataProximaFatura(), diasAntesDeAviso);
	}

}
