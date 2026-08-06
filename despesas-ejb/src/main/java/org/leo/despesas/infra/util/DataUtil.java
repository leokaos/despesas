package org.leo.despesas.infra.util;

import java.time.Clock;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import org.apache.commons.lang3.time.DateUtils;
import org.leo.despesas.infra.Periodo;

public final class DataUtil extends DateUtils {

	public static Clock CLOCK = Clock.systemDefaultZone();

	public static void setClock(Clock newClock) {
		CLOCK = newClock;
	}

	public static Periodo getMesAtual() {
		return getMes(LocalDate.now(CLOCK));
	}

	public static Periodo getMes(final LocalDate dataBase) {

		LocalDate dataInicial = dataBase.withDayOfMonth(1);
		LocalDate dataFinal = dataBase.withDayOfMonth(dataBase.lengthOfMonth());

		return new Periodo(dataInicial, dataFinal);
	}

	public static boolean estaNosProximosDias(final LocalDate targetDate, int days) {

		LocalDate hoje = LocalDate.now(CLOCK);

		if (hoje.isAfter(targetDate)) {
			return false;
		}

		return ChronoUnit.DAYS.between(hoje, targetDate) <= days;
	}

}