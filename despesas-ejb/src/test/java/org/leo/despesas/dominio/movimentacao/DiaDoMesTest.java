package org.leo.despesas.dominio.movimentacao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.jupiter.api.Test;
import org.leo.despesas.infra.exception.DespesasException;

public class DiaDoMesTest {

	private static DateFormat FORMAT = new SimpleDateFormat("yyyy-MM-dd");

	@Test
	public void deveriaSoltarExcecaoPorqueDiaMaiorQue28AdaptarFalseTest() {
		DespesasException exception = assertThrows(DespesasException.class, () -> DiaDoMes.from(30, false));
		assertEquals("Dia nao permitido!", exception.getMessage());
	}

	@Test
	public void deveriaSoltarExcecaoPorqueDiaMaiorQue31Test() {
		DespesasException exception = assertThrows(DespesasException.class, () -> DiaDoMes.from(40, true));
		assertEquals("Dia nao permitido!", exception.getMessage());
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
