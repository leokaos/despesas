package org.leo.despesas.infra;

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

	@Override
	public String toString() {
		return new StringBuilder().append(dataInicial).append(" - ").append(dataFinal).toString();
	}

	public boolean pertenceAoPeriodo(Date dataBase) {
		return dataInicial.before(dataBase) && dataFinal.after(dataBase);
	}
}
