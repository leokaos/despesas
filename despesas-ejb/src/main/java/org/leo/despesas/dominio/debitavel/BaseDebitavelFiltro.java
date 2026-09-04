package org.leo.despesas.dominio.debitavel;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;
import org.leo.despesas.infra.ModelEntity;
import org.leo.despesas.infra.Moeda;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public abstract class BaseDebitavelFiltro<T extends ModelEntity> extends AbstractModelFiltro<T> {

	@QueryParam("moeda")
	private Moeda moeda;

	@QueryParam("ativo")
	private Boolean ativo;

	@Override
	protected void build() {
		eq("moeda", moeda);
		eq("ativo", ativo);

		internalBuild();
	}

	protected void internalBuild() {

	}
}
