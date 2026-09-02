package org.leo.despesas.dominio.debitavel;

import java.util.Arrays;

import javax.ws.rs.QueryParam;

public class DebitavelFiltro extends BaseDebitavelFiltro<Debitavel> {

	@QueryParam("tipo")
	private String tipos;

	public DebitavelFiltro() {
		super();
	}

	@Override
	protected void internalBuild() {
		super.internalBuild();

		in("tipo", Arrays.asList(tipos.split(",")));
	}
}
