package org.leo.despesas.infra;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;

import org.junit.Test;

public class PeriodoIteratorTest {

	private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");

	@Test
	public void test() throws Exception {

		Periodo periodo = new Periodo(DATE_FORMAT.parse("01/01/2019"), DATE_FORMAT.parse("31/12/2019"));

		Iterator<Date> iterator = null;

		while (iterator.hasNext()) {

			Date date = iterator.next();
			System.out.println(date);
		}

	}

}
