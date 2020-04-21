package org.leo.despesas.aplicacao.debitavel;

import java.util.Comparator;

import org.leo.despesas.dominio.debitavel.Debitavel;

public class DebitavelPreferivelComparator implements Comparator<Debitavel> {

	private Integer idContaPreferivel;

	public DebitavelPreferivelComparator(Integer idContaPreferivel) {
		super();
		this.idContaPreferivel = idContaPreferivel;
	}

	@Override
	public int compare(Debitavel o1, Debitavel o2) {
		return o1.getId().intValue() == idContaPreferivel ? Integer.MIN_VALUE : Integer.MAX_VALUE;
	}

}
