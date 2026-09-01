package org.leo.despesas.dominio.debitavel;

import java.util.Arrays;
import java.util.List;

public class DividaFiltro extends BaseDebitavelFiltro<Divida> {

	private List<Periodicidade> periodicidades;

	public List<Periodicidade> getPeriodicidades() {
		return periodicidades;
	}

	public void setPeriodicidades(List<Periodicidade> periodicidades) {
		this.periodicidades = periodicidades;
	}

	public void setPeriodicidades(Periodicidade... periodicidades) {
		this.periodicidades = Arrays.asList(periodicidades);
	}

	@Override
	protected void internalBuild() {
		in("periodicidade", periodicidades);
	}

}
