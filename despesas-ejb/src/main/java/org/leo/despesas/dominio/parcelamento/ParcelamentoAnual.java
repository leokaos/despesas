package org.leo.despesas.dominio.parcelamento;

import java.math.BigDecimal;
import java.util.Date;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.infra.DataUtil;

public class ParcelamentoAnual extends Parcelamento {

	public static final String CODIGO = "Anual";

	public ParcelamentoAnual(BigDecimal numeroParcelas, Despesa despesa) {
		super(numeroParcelas, despesa);
	}

	@Override
	public Date getDataParcela(int numeroParcela) {
		return DataUtil.addYears(despesa.getVencimento(), numeroParcela);
	}

	@Override
	public String getCodigo() {
		return CODIGO;
	}
}
