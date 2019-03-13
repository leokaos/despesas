package org.leo.despesas.dominio.movimentacao;

import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang3.time.DateUtils;
import org.leo.despesas.infra.exception.DespesasException;

public final class DiaDoMes {

	private final int dia;

	private final boolean adaptarDiaAoMes;

	private DiaDoMes(int dia, boolean adaptarDiaAoMes) {
		super();
		this.dia = dia;
		this.adaptarDiaAoMes = adaptarDiaAoMes;
	}

	public static DiaDoMes from(int dia,
			boolean adaptarDiaAoMes)
			throws DespesasException {

		if (dia > 28 && !adaptarDiaAoMes || dia > 31) {
			throw new DespesasException("Dia nao permitido!");
		}

		return new DiaDoMes(dia, adaptarDiaAoMes);
	}

	public int getDia() {
		return dia;
	}

	public boolean isAdaptarDiaAoMes() {
		return adaptarDiaAoMes;
	}

	public Date getNext(Date inicial) {

		Calendar calendar = DateUtils.toCalendar(inicial);

		int diaAtual = calendar.get(Calendar.DAY_OF_MONTH);

		if (diaAtual <= dia && dia <= 28) {
			return DateUtils.setDays(inicial, dia);
		}

		if (dia > calendar.getActualMaximum(Calendar.DAY_OF_MONTH)) {
			return DateUtils.setDays(inicial, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		}

		return DateUtils.addMonths(DateUtils.setDays(inicial, dia), 1);
	}

}
