package org.leo.despesas.dominio;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.LocalDate;

import org.junit.jupiter.api.Test;
import org.leo.despesas.infra.Periodo;

public class PeriodoTest {

	@Test
	public void pertenceAoPeriodoTest() {
		final LocalDate dataBase = LocalDate.now();

		Periodo periodo = new Periodo(dataBase, dataBase.plusDays(10));

		assertFalse(periodo.pertenceAoPeriodo(dataBase.minusDays(10)));
		assertTrue(periodo.pertenceAoPeriodo(dataBase.plusDays(5)));
		assertFalse(periodo.pertenceAoPeriodo(dataBase.plusDays(15)));
	}
}