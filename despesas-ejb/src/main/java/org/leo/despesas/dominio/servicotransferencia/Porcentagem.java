package org.leo.despesas.dominio.servicotransferencia;

import static java.lang.Double.NaN;

public class Porcentagem {

	private final double valor;

	private Porcentagem(double valor) {
		super();
		this.valor = valor;
	}

	public static Porcentagem from(Double valor) {

		if (valor == null || valor.equals(NaN)) {
			return null;
		}

		return new Porcentagem(valor);
	}

	public double getValor() {
		return valor;
	}

	public double getPorcentagem() {
		return valor / 100;
	}

	public double getComplemento() {
		return 1 - getPorcentagem();
	}

}
