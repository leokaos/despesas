package org.leo.despesas.dominio.feriado;

import java.util.Date;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;

public class FeriadoFiltro extends AbstractModelFiltro<Feriado> {

	@QueryParam("dataInicial")
	private Date dataInicial;

	@QueryParam("dataFinal")
	private Date dataFinal;

	public FeriadoFiltro() {
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

	@Override
	protected void build() {

		between("data", dataInicial, dataFinal);

	}

}
