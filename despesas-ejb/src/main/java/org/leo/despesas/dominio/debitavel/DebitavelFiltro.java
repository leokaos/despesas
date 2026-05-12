package org.leo.despesas.dominio.debitavel;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;
import org.leo.despesas.infra.Moeda;

public class DebitavelFiltro extends AbstractModelFiltro<Debitavel> {

	@QueryParam("moeda")
	private Moeda moeda;

	@QueryParam("ativo")
	private Boolean ativo;

	public DebitavelFiltro() {
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

}
