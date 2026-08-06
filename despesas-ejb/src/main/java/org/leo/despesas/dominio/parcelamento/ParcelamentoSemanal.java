package org.leo.despesas.dominio.parcelamento;

import java.time.LocalDate;

import org.leo.despesas.dominio.movimentacao.Despesa;

public class ParcelamentoSemanal extends Parcelamento {

	public static final String CODIGO = "Semanal";

	public ParcelamentoSemanal() {
		super();
	}

	@Override
	public LocalDate getDataParcela(int numeroParcela,Despesa despesa) {
		return despesa.getVencimento().plusDays(numeroParcela * 7);
	}

	@Override
	public String getCodigo() {
		return CODIGO;
	}
}
