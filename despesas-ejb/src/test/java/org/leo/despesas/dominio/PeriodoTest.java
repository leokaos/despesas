package org.leo.despesas.dominio;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.Date;

import org.junit.Test;
import org.leo.despesas.infra.DataUtil;
import org.leo.despesas.infra.Periodo;

public class PeriodoTest {

	@Test
	public void pertenceAoPeriodoTest() {
		final Date dataBase = new Date();

		final Periodo periodo = new Periodo(dataBase, DataUtil.addDays(dataBase, 10));

		assertFalse(periodo.pertenceAoPeriodo(DataUtil.addDays(dataBase, -10)));
		assertTrue(periodo.pertenceAoPeriodo(DataUtil.addDays(dataBase, 5)));
		assertFalse(periodo.pertenceAoPeriodo(DataUtil.addDays(dataBase, 15)));
	}

}
