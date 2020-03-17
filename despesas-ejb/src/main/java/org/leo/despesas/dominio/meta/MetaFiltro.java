package org.leo.despesas.dominio.meta;

import java.util.Date;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;
import org.leo.despesas.infra.Periodo;

public class MetaFiltro extends AbstractModelFiltro<Meta> {

	@QueryParam("dataInicial")
	private Date dataInicial;

	@QueryParam("dataFinal")
	private Date dataFinal;

	@Override
	protected void build() {

		if (dataInicial != null && dataFinal != null) {
			eq("periodo", new Periodo(dataInicial, dataInicial));
		}

	}

}
