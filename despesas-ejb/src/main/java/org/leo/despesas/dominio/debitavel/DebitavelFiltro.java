package org.leo.despesas.dominio.debitavel;

import java.util.Arrays;

import javax.ws.rs.QueryParam;

import org.apache.commons.lang3.StringUtils;

public class DebitavelFiltro extends BaseDebitavelFiltro<Debitavel> {

	@QueryParam("tipo")
	private String tipos;

	public DebitavelFiltro() {
		super();
	}

	@Override
	protected void internalBuild() {
		super.internalBuild();

		if (StringUtils.isNotBlank(tipos)) {
			in("tipo", Arrays.asList(tipos.split(",")));
		}

	}
}
