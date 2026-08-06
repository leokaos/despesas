package org.leo.despesas.infra;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Iterator;

public class PeriodoIterator implements Iterator<LocalDate> {

	private final ChronoUnit chronoUnit;
	private final Periodo periodo;
	private LocalDate atual;

	public PeriodoIterator(ChronoUnit chronoUnit, Periodo periodo) {
		super();
		this.chronoUnit = chronoUnit;
		this.periodo = periodo;
	}

	@Override
	public boolean hasNext() {
		if (atual == null) {
			return true;
		}

		LocalDate proximo = addField(atual);
		return !proximo.isAfter(periodo.getDataFinal());
	}

	@Override
	public LocalDate next() {
		if (atual == null) {
			atual = periodo.getDataInicial();
		} else {
			atual = addField(atual);
		}

		return atual;
	}

	private LocalDate addField(LocalDate target) {
		LocalDate retorno = null;

		switch (chronoUnit) {
		case YEARS:
			retorno = target.plusYears(1);
			break;

		case MONTHS:
			retorno = target.plusMonths(1);
			break;

		case DAYS:
			retorno = target.plusDays(1);
			break;

		default:
			throw new IllegalArgumentException("Unsupported ChronoUnit: " + chronoUnit);
		}

		return retorno;
	}

	@Override
	public void remove() {
		throw new UnsupportedOperationException("Remove operation not supported");
	}
}