package org.leo.despesas.dominio;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.Clock;
import java.time.LocalDate;
import java.time.ZoneId;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.util.DataUtil;

public class PeriodoTest {

	@BeforeEach
	public void before() {
		DataUtil.setClock(Clock.fixed(LocalDate.of(2026, 1, 2).atStartOfDay(ZoneId.systemDefault()).toInstant(), ZoneId.systemDefault()));
	}

	@AfterEach
	public void after() {
		DataUtil.setClock(Clock.systemDefaultZone());
	}

	@Test
	void pertenceAoPeriodoTest() {
		final LocalDate dataBase = LocalDate.now(DataUtil.CLOCK);

		Periodo periodo = new Periodo(dataBase, dataBase.plusDays(10));

		assertFalse(periodo.pertenceAoPeriodo(dataBase.minusDays(10)));
		assertTrue(periodo.pertenceAoPeriodo(dataBase.plusDays(5)));
		assertFalse(periodo.pertenceAoPeriodo(dataBase.plusDays(15)));
	}

	@Test
	void getDiasParaTerminoTest() throws Exception {

		final LocalDate dataBase = LocalDate.now(DataUtil.CLOCK);

		assertEquals(1, new Periodo(dataBase, dataBase).getDiasParaTermino());

		assertEquals(11, new Periodo(dataBase, dataBase.plusDays(10)).getDiasParaTermino());
	}
}