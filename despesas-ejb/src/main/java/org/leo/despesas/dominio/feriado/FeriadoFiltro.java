package org.leo.despesas.dominio.feriado;

import java.time.LocalDate;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;

public class FeriadoFiltro extends AbstractModelFiltro<Feriado> {

	@QueryParam("dataInicial")
	private LocalDate dataInicial;

	@QueryParam("dataFinal")
	private LocalDate dataFinal;

	public FeriadoFiltro() {
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

	@Override
	protected void build() {

		between("data", dataInicial,dataFinal);

	}

}
