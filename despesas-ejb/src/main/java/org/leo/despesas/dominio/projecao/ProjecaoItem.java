package org.leo.despesas.dominio.projecao;

import java.math.BigDecimal;
import java.util.Date;

public class ProjecaoItem {

	private Date data;
	private BigDecimal valor;

	public ProjecaoItem(Date data, BigDecimal valor) {
		super();
		this.data = data;
		this.valor = valor;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public BigDecimal getValor() {
		return valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

}
