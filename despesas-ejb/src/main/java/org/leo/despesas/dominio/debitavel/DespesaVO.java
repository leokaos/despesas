package org.leo.despesas.dominio.debitavel;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.parcelamento.ParcelamentoVO;

public class DespesaVO {

	private Despesa despesa;
	private ParcelamentoVO parcelamentoVO;

	public DespesaVO() {
		super();
	}

	public Despesa getDespesa() {
		return despesa;
	}

	public void setDespesa(Despesa despesa) {
		this.despesa = despesa;
	}

	public ParcelamentoVO getParcelamentoVO() {
		return parcelamentoVO;
	}

	public void setParcelamentoVO(ParcelamentoVO parcelamentoVO) {
		this.parcelamentoVO = parcelamentoVO;
	}

}
