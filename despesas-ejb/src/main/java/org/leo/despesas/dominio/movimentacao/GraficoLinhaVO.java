package org.leo.despesas.dominio.movimentacao;

import java.math.BigDecimal;

public class GraficoLinhaVO extends GraficoVO {

	private final BigDecimal valorY;

	public GraficoLinhaVO(final String legenda, final String cor, final BigDecimal valor, final BigDecimal valorY) {
		super(legenda, cor, valor);

		this.valorY = valorY;
	}

	public BigDecimal getValorY() {
		return valorY;
	}

}
