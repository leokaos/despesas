package org.leo.despesas.dominio.parcelamento;

import java.time.LocalDate;

import org.leo.despesas.dominio.movimentacao.Despesa;

public class ParcelamentoSemestral extends Parcelamento {

	public static final String CODIGO = "Semestral";

	public ParcelamentoSemestral() {
		super();
	}

	@Override
	public String getCodigo() {
		return CODIGO;
	}

	@Override
	public LocalDate getDataParcela(int numeroParcela, Despesa despesa) {
		return despesa.getVencimento().plusMonths(6 * numeroParcela);
	}
}
