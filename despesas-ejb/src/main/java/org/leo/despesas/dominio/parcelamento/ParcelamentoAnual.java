package org.leo.despesas.dominio.parcelamento;

import java.time.LocalDate;

import org.leo.despesas.dominio.movimentacao.Despesa;

public class ParcelamentoAnual extends Parcelamento {

	public static final String CODIGO = "Anual";

	public ParcelamentoAnual() {
		super();
	}

	@Override
	public LocalDate getDataParcela(int numeroParcela, Despesa despesa) {
		return despesa.getVencimento().plusYears(numeroParcela);
	}

	@Override
	public String getCodigo() {
		return CODIGO;
	}
}
