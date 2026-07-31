package org.leo.despesas.dominio.alerta;

import static org.leo.despesas.infra.util.DataUtil.CLOCK;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.function.Function;

public enum TipoPeriodicidade {

	DIA_UTIL(alerta -> {

		LocalDate data = LocalDate.now(CLOCK);

		if (data.getDayOfMonth() > alerta.getDiaAlvo()) {
			data = data.withDayOfMonth(alerta.getDiaAlvo()).plusMonths(1);
		} else {
			data = data.withDayOfMonth(alerta.getDiaAlvo());
		}

		while (data.getDayOfWeek() == DayOfWeek.SATURDAY || data.getDayOfWeek() == DayOfWeek.SUNDAY) {
			data = data.plusDays(1);
		}

		return data;
	});

	private final Function<AlertaDespesaRecorrente, LocalDate> calculator;

	private TipoPeriodicidade(Function<AlertaDespesaRecorrente, LocalDate> calculator) {
		this.calculator = calculator;
	}

	public Function<AlertaDespesaRecorrente, LocalDate> getCalculator() {
		return calculator;
	}

}
