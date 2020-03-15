package org.leo.despesas.dominio.orcamento;

import java.util.Date;

import javax.ws.rs.QueryParam;

import org.apache.commons.lang3.time.DateUtils;
import org.leo.despesas.infra.AbstractModelFiltro;

public class OrcamentoFiltro extends AbstractModelFiltro<Orcamento> {

	@QueryParam("dataInicial")
	private Date dataInicial;

	@QueryParam("dataFinal")
	private Date dataFinal;

	@QueryParam("tipoDespesa")
	private String tipoDespesa;

	public OrcamentoFiltro() {
		super();
	}

	public Date getDataInicial() {
		return dataInicial;
	}

	public void setDataInicial(Date dataInicial) {
		this.dataInicial = dataInicial;
	}

	public Date getDataFinal() {
		return dataFinal;
	}

	public void setDataFinal(Date dataFinal) {
		this.dataFinal = dataFinal;
	}

	public String getTipoDespesa() {
		return tipoDespesa;
	}

	public void setTipoDespesa(String tipoDespesa) {
		this.tipoDespesa = tipoDespesa;
	}

	public boolean hasDataInicialAndDataFinal() {
		return dataInicial != null && dataFinal != null;
	}

	public boolean hasDataInicial() {
		return dataInicial != null;
	}

	public boolean hasDataFinal() {
		return dataFinal != null;
	}

	public boolean hasTipoDespesa() {
		return tipoDespesa != null;
	}

	@Override
	protected void build() {

		if (dataInicial != null) {
			dataInicial = DateUtils.setMilliseconds(dataInicial, 0);
		}

		if (dataFinal != null) {
			dataFinal = DateUtils.setMilliseconds(dataFinal, 999);
		}

		greaterOrEqualThan("dataInicial", dataInicial);

		lessOrEqualThan("dataFinal", dataFinal);

		eq("tipo.descricao", tipoDespesa);

	}

}
