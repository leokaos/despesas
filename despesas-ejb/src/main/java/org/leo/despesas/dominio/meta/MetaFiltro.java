package org.leo.despesas.dominio.meta;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;
import org.leo.despesas.infra.Mes;

public class MetaFiltro extends AbstractModelFiltro<Meta> {

	@QueryParam("ano")
	private Integer ano;

	@QueryParam("mes")
	private Integer mes;

	@Override
	protected void build() {

		if (ano != null && mes != null) {
			eq("mes", new Mes(mes, ano));
		}

	}

}
