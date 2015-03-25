package org.leo.despesas.dominio.movimentacao;

import java.math.BigDecimal;

public class GraficoVO {

	private final String legenda;
	private final String cor;
	private final BigDecimal valor;

	public GraficoVO(String legenda, String cor, BigDecimal valor) {
		super();
		this.legenda = legenda;
		this.cor = cor;
		this.valor = valor;
	}

	public String getLegenda() {
		return legenda;
	}

	public BigDecimal getValor() {
		return valor;
	}

	public String getCor() {
		return cor;
	}

	@Override
	public String toString() {
		return legenda.concat(" ").concat(valor.toString());
	}

}
