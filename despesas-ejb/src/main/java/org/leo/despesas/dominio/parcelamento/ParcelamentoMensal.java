package org.leo.despesas.dominio.parcelamento;

import java.time.LocalDate;

import org.leo.despesas.dominio.movimentacao.Despesa;

public class ParcelamentoMensal extends Parcelamento {

	public static final String CODIGO = "Mensal";

	public ParcelamentoMensal() {
		super();
	}

	@Override
	public LocalDate getDataParcela(int numeroParcela, Despesa despesa) {
		return despesa.getVencimento().plusMonths(numeroParcela);
	}

	@Override
	public String getCodigo() {
		return CODIGO;
	}
}
