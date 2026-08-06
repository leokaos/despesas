package org.leo.despesas.dominio.orcamento;

import java.time.LocalDate;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;

public class OrcamentoFiltro extends AbstractModelFiltro<Orcamento> {

	@QueryParam("dataInicial")
	private LocalDate dataInicial;

	@QueryParam("dataFinal")
	private LocalDate dataFinal;

	@QueryParam("tipoDespesa")
	private String tipoDespesa;

	public OrcamentoFiltro() {
		super();
	}

	public LocalDate getDataInicial() {
		return dataInicial;
	}

	public void setDataInicial(LocalDate dataInicial) {
		this.dataInicial = dataInicial;
	}

	public LocalDate getDataFinal() {
		return dataFinal;
	}

	public void setDataFinal(LocalDate dataFinal) {
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

		greaterOrEqualThan("dataInicial", dataInicial);

		lessOrEqualThan("dataFinal", dataFinal);

		eq("tipoDespesa.descricao", tipoDespesa);

	}

}
