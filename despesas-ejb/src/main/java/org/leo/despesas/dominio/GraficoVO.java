package org.leo.despesas.dominio;

import java.math.BigDecimal;

public class GraficoVO {

	private final String descricaoTipoDespesa;
	private final BigDecimal valor;

	public GraficoVO(String descricaoTipoDespesa, BigDecimal valor) {
		super();
		this.descricaoTipoDespesa = descricaoTipoDespesa;
		this.valor = valor;
	}

	public String getDescricaoTipoDespesa() {
		return descricaoTipoDespesa;
	}

	public BigDecimal getValor() {
		return valor;
	}

	@Override
	public String toString() {
		return descricaoTipoDespesa.concat(" ").concat(valor.toString());
	}

}
