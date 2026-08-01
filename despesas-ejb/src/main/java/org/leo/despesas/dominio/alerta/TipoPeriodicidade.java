package org.leo.despesas.dominio.alerta;

import static org.leo.despesas.infra.util.DataUtil.CLOCK;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.function.Function;

public enum TipoPeriodicidade {

	DIA_UTIL(diaAlvo -> {

		LocalDate data = LocalDate.now(CLOCK);

		if (data.getDayOfMonth() > diaAlvo) {
			data = data.withDayOfMonth(diaAlvo).plusMonths(1);
		} else {
			data = data.withDayOfMonth(diaAlvo);
		}

		while (data.getDayOfWeek() == DayOfWeek.SATURDAY || data.getDayOfWeek() == DayOfWeek.SUNDAY) {
			data = data.plusDays(1);
		}

		return data;
	});

	private final Function<Integer, LocalDate> calculator;

	private TipoPeriodicidade(Function<Integer, LocalDate> calculator) {
		this.calculator = calculator;
	}

	public Function<Integer, LocalDate> getCalculator() {
		return calculator;
	}

}
