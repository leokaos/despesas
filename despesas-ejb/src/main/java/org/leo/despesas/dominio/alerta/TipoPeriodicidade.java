package org.leo.despesas.dominio.alerta;

import java.time.DayOfWeek;
import java.time.LocalDate;

public enum TipoPeriodicidade {

	DIA_UTIL(alerta -> {

		LocalDate data = LocalDate.now().withDayOfMonth(alerta.getDiaAlvo());

		while (data.getDayOfWeek() == DayOfWeek.SATURDAY || data.getDayOfWeek() == DayOfWeek.SUNDAY) {
			data = data.plusDays(1);
		}

		return data;
	});

	private final TipoPeriodicidadeCalculator calculator;

	private TipoPeriodicidade(TipoPeriodicidadeCalculator calculator) {
		this.calculator = calculator;
	}

	public TipoPeriodicidadeCalculator getCalculator() {
		return calculator;
	}

}
