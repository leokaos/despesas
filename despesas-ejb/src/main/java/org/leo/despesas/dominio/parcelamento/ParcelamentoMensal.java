package org.leo.despesas.dominio.parcelamento;

import java.util.Date;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.infra.util.DataUtil;

public class ParcelamentoMensal extends Parcelamento {

	public static final String CODIGO = "Mensal";

	public ParcelamentoMensal() {
		super();
	}

	@Override
	public Date getDataParcela(int numeroParcela,Despesa despesa) {
		return DataUtil.addMonths(despesa.getVencimento(),numeroParcela);
	}

	@Override
	public String getCodigo() {
		return CODIGO;
	}
}
