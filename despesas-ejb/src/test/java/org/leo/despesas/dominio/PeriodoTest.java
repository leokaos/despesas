package org.leo.despesas.dominio;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Date;

import org.junit.jupiter.api.Test;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.util.DataUtil;

public class PeriodoTest {

	@Test
	public void pertenceAoPeriodoTest() {
		final Date dataBase = new Date();

		Periodo periodo = new Periodo(dataBase,DataUtil.addDays(dataBase,10));

		assertFalse(periodo.pertenceAoPeriodo(DataUtil.addDays(dataBase,-10)));
		assertTrue(periodo.pertenceAoPeriodo(DataUtil.addDays(dataBase,5)));
		assertFalse(periodo.pertenceAoPeriodo(DataUtil.addDays(dataBase,15)));
	}

}
