package org.leo.despesas.infra.util;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.Clock;
import java.time.LocalDate;
import java.time.ZoneId;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class DataUtilTest {

	@BeforeEach
	public void setup() {

		Clock clock = Clock.fixed(LocalDate.of(2026, 1, 2).atStartOfDay(ZoneId.systemDefault()).toInstant(), ZoneId.systemDefault());

		DataUtil.setClock(clock);
	}

	@Test
	public void deveriaVerificarTodoOPeriodo() {

		assertFalse(DataUtil.estaNosProximosDias(LocalDate.of(2026, 1, 1), 5));

		assertTrue(DataUtil.estaNosProximosDias(LocalDate.of(2026, 1, 2), 5));
		assertTrue(DataUtil.estaNosProximosDias(LocalDate.of(2026, 1, 3), 5));
		assertTrue(DataUtil.estaNosProximosDias(LocalDate.of(2026, 1, 4), 5));
		assertTrue(DataUtil.estaNosProximosDias(LocalDate.of(2026, 1, 5), 5));
		assertTrue(DataUtil.estaNosProximosDias(LocalDate.of(2026, 1, 6), 5));
		assertTrue(DataUtil.estaNosProximosDias(LocalDate.of(2026, 1, 7), 5));
		
		assertFalse(DataUtil.estaNosProximosDias(LocalDate.of(2026, 1, 8), 5));
	}

}
