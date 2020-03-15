package org.leo.despesas.dominio.meta;

import org.leo.despesas.infra.AbstractModelFiltro;
import org.leo.despesas.infra.Periodo;

public class MetaFiltro extends AbstractModelFiltro<Meta> {

	private Periodo periodo;

	@Override
	protected void build() {

		if (periodo != null) {
			this.eq("periodo", periodo);
		}

	}

}
