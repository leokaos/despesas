package org.leo.despesas.infra;

import static org.junit.Assert.*;

import java.util.Calendar;
import java.util.Date;

import org.junit.Test;
import org.leo.despesas.infra.util.DataUtil;

public class MesTest {

	@Test
	public void test() {
		Date dataBase = new Date();

//		dataBase = DataUtil.setMonths(dataBase, 3);

		Calendar instance = Calendar.getInstance();
		instance.setTime(dataBase);

		instance.set(Calendar.MONTH, 3);
		System.out.println(dataBase);
	}

}
