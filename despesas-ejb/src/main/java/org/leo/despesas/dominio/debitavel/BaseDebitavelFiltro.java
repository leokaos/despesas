package org.leo.despesas.dominio.debitavel;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;
import org.leo.despesas.infra.ModelEntity;
import org.leo.despesas.infra.Moeda;

public abstract class BaseDebitavelFiltro<T extends ModelEntity> extends AbstractModelFiltro<T> {

	@QueryParam("moeda")
	private Moeda moeda;

	@QueryParam("ativo")
	private Boolean ativo;

	public BaseDebitavelFiltro() {
		super();
	}

	public Moeda getMoeda() {
		return moeda;
	}

	public void setMoeda(Moeda moeda) {
		this.moeda = moeda;
	}

	@Override
	protected void build() {
		eq("moeda", moeda);
		eq("ativo", ativo);
	}

	protected void internalBuild() {

	}
}
