package org.leo.despesas.dominio.debitavel;

import java.util.ArrayList;
import java.util.List;

public enum BandeiraCartaoCredito {

	VISA("Visa"), MASTERCARD("MasterCard"), AMERICAN_EXPRESS("American Express");

	private static List<BandeiraCartaoCredito> VALORES;

	static {
		VALORES = new ArrayList<BandeiraCartaoCredito>();

		VALORES.add(VISA);
		VALORES.add(MASTERCARD);
		VALORES.add(AMERICAN_EXPRESS);
	}

	private final String nome;

	private BandeiraCartaoCredito(String nome) {
		this.nome = nome;
	}

	public String getNome() {
		return nome;
	}

	public static BandeiraCartaoCredito parse(String nome) {

		for (BandeiraCartaoCredito bandeiraCartaoCredito : VALORES) {
			if (bandeiraCartaoCredito.getNome().equalsIgnoreCase(nome)) {
				return bandeiraCartaoCredito;
			}
		}

		return null;
	}

}
