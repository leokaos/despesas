package org.leo.despesas.dominio.parcelamento;

import java.util.Date;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.infra.DataUtil;

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
	public Date getDataParcela(int numeroParcela,Despesa despesa) {
		return DataUtil.addMonths(despesa.getVencimento(),6 * numeroParcela);
	}
}
