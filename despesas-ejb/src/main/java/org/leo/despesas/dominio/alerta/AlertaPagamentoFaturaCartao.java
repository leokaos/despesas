package org.leo.despesas.dominio.alerta;

import java.util.Optional;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.notificacao.Notificacao;

@Entity
@Table(name = "alerta_pagamento_fatura_cartao", schema = "despesas_db")
public class AlertaPagamentoFaturaCartao extends Alerta {

	private static final long serialVersionUID = -6444085653952299136L;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "cartao_credito_id", nullable = true)
	private CartaoCredito cartao;

	public AlertaPagamentoFaturaCartao() {
		super();
	}

	public CartaoCredito getCartao() {
		return cartao;
	}

	public void setCartao(CartaoCredito cartao) {
		this.cartao = cartao;
	}

	@Override
	public Optional<Notificacao> gerarNotificacao() {
		return Optional.empty();
	}

	@Override
	public String getDescricao() {
		return "Pagar fatura para " + this.cartao.getDescricao();
	}

}
