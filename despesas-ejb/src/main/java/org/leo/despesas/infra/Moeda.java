package org.leo.despesas.infra;

public enum Moeda {

	EURO("EUR"), REAL("BRL");

	private final String codigo;

	private Moeda(String codigo) {
		this.codigo = codigo;
	}

	public String getCodigo() {
		return codigo;
	}

}
