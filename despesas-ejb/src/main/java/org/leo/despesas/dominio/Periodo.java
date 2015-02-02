package org.leo.despesas.dominio;

import java.util.Date;

public class Periodo {

	private final Date dataInicial;
	private final Date dataFinal;

	public Periodo(Date dataInicial, Date dataFinal) {
		super();
		this.dataInicial = dataInicial;
		this.dataFinal = dataFinal;
	}

	public Date getDataInicial() {
		return dataInicial;
	}

	public Date getDataFinal() {
		return dataFinal;
	}

}
