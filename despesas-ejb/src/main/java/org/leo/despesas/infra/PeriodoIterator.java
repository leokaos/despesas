package org.leo.despesas.infra;

import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;

import org.apache.commons.lang3.time.DateUtils;

public class PeriodoIterator implements Iterator<Date> {

	private int calendarField;
	private Periodo periodo;

	private Date atual;

	public PeriodoIterator(int calendarField, Periodo periodo) {
		super();
		this.calendarField = calendarField;
		this.periodo = periodo;
	}

	@Override
	public boolean hasNext() {

		if (atual == null) {
			return true;
		}

		return addField(atual).before(periodo.getDataFinal());
	}

	@Override
	public Date next() {

		if (atual == null) {
			atual = periodo.getDataInicial();
		} else {
			atual = addField(atual);
		}

		return atual;
	}

	private Date addField(Date target) {

		Date retorno = null;

		switch (calendarField) {
			case Calendar.YEAR :
				retorno = DateUtils.addYears(atual, 1);
				break;

			case Calendar.MONTH :
				retorno = DateUtils.addMonths(atual, 1);
				break;

			case Calendar.DAY_OF_MONTH :
				retorno = DateUtils.addDays(atual, 1);
				break;

			case Calendar.HOUR_OF_DAY :
				retorno = DateUtils.addHours(atual, 1);
				break;

			default :
				throw new IllegalArgumentException();
		}

		return retorno;
	}

	@Override
	public void remove() {

	}

}
