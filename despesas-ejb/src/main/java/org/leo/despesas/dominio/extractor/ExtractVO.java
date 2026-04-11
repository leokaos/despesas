package org.leo.despesas.dominio.extractor;

import java.math.BigDecimal;

public class ExtractVO {

	private String data;
	private BigDecimal valor;
	private String descricao;

	public ExtractVO() {
		super();
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public BigDecimal getValor() {
		return valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

}
