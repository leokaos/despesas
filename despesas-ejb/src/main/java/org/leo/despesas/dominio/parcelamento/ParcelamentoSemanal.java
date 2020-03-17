package org.leo.despesas.dominio.parcelamento;

import java.util.Date;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.infra.util.DataUtil;

public class ParcelamentoSemanal extends Parcelamento {

	public static final String CODIGO = "Semanal";

	public ParcelamentoSemanal() {
		super();
	}

	@Override
	public Date getDataParcela(int numeroParcela,Despesa despesa) {
		return DataUtil.addDays(despesa.getVencimento(),numeroParcela * 7);
	}

	@Override
	public String getCodigo() {
		return CODIGO;
	}
}
