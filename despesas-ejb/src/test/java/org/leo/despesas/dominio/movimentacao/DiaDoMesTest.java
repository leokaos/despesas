package org.leo.despesas.dominio.movimentacao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;
import org.leo.despesas.infra.exception.DespesasException;

public class DiaDoMesTest {

	private static DateFormat FORMAT = new SimpleDateFormat("yyyy-MM-dd");

	@Test
	public void deveriaSoltarExcecaoPorqueDiaMaiorQue28AdaptarFalseTest() {
		try {
			DiaDoMes.from(30, false);
			fail();
		} catch (DespesasException e) {
			assertEquals("Dia nao permitido!", e.getMessage());
		}
	}

	@Test
	public void deveriaSoltarExcecaoPorqueDiaMaiorQue31Test() {
		try {
			DiaDoMes.from(40, true);
			fail();
		} catch (DespesasException e) {
			assertEquals("Dia nao permitido!", e.getMessage());
		}
	}

	@Test
	public void deveriaRetornarProximoDiaDeExecucaoComDiaMenorQueAtualTest() throws Exception {

		DiaDoMes diaDoMes = DiaDoMes.from(5, true);
		
		Date dataBase = FORMAT.parse("2019-03-01");

		Date proximaData = diaDoMes.getNext(dataBase);

		assertEquals(FORMAT.parse("2019-03-05"), proximaData);
	}
	
	@Test
	public void deveriaRetornarProximoDiaDeExecucaoComDiaTrintaTest() throws Exception {

		DiaDoMes diaDoMes = DiaDoMes.from(30, true);
		
		Date dataBase = FORMAT.parse("2019-02-01");

		Date proximaData = diaDoMes.getNext(dataBase);

		assertEquals(FORMAT.parse("2019-02-28"), proximaData);
	}
	
	@Test
	public void deveriaRetornarDataNoProximoMesTest() throws Exception {
		
		DiaDoMes diaDoMes = DiaDoMes.from(5, true);

		Date dataBase = FORMAT.parse("2019-02-25");

		Date proximaData = diaDoMes.getNext(dataBase);

		assertEquals(FORMAT.parse("2019-03-05"), proximaData);
	}

}
