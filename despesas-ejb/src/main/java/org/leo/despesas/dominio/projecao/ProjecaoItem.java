package org.leo.despesas.dominio.projecao;

import java.math.BigDecimal;
import java.time.LocalDate;

public class ProjecaoItem {

	private LocalDate data;
	private BigDecimal valor;

	public ProjecaoItem(LocalDate data, BigDecimal valor) {
		super();
		this.data = data;
		this.valor = valor;
	}

	public LocalDate getData() {
		return data;
	}

	public void setData(LocalDate data) {
		this.data = data;
	}

	public BigDecimal getValor() {
		return valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

}
