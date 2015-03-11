package org.leo.despesas.dominio.movimentacao;

import java.math.BigDecimal;

public class GraficoVO {

	private final String descricaoTipoDespesa;
	private final String cor;
	private final BigDecimal valor;

	public GraficoVO(String descricaoTipoDespesa, String cor, BigDecimal valor) {
		super();
		this.descricaoTipoDespesa = descricaoTipoDespesa;
		this.cor = cor;
		this.valor = valor;
	}

	public String getDescricaoTipoDespesa() {
		return descricaoTipoDespesa;
	}

	public BigDecimal getValor() {
		return valor;
	}

	public String getCor() {
		return cor;
	}

	@Override
	public String toString() {
		return descricaoTipoDespesa.concat(" ").concat(valor.toString());
	}

}
