package org.leo.despesas.infra.util;

import static org.junit.Assert.*;

import java.time.LocalDate;

import org.junit.Test;

public class DataUtilTest {

	@Test
	public void deveriaVerificarTodoOPeriodo() {

		LocalDate doisDiasAtras = LocalDate.now().minusDays(2);

		assertFalse(DataUtil.estaNosProximosDias(doisDiasAtras, 5));
		assertFalse(DataUtil.estaNosProximosDias(doisDiasAtras.plusDays(1), 5));

		assertTrue(DataUtil.estaNosProximosDias(doisDiasAtras.plusDays(2), 5));
		assertTrue(DataUtil.estaNosProximosDias(doisDiasAtras.plusDays(3), 5));
		assertTrue(DataUtil.estaNosProximosDias(doisDiasAtras.plusDays(4), 5));
		assertTrue(DataUtil.estaNosProximosDias(doisDiasAtras.plusDays(5), 5));
		assertTrue(DataUtil.estaNosProximosDias(doisDiasAtras.plusDays(6), 5));
		assertTrue(DataUtil.estaNosProximosDias(doisDiasAtras.plusDays(7), 5));

		assertFalse(DataUtil.estaNosProximosDias(doisDiasAtras.plusDays(8), 5));
	}

}
