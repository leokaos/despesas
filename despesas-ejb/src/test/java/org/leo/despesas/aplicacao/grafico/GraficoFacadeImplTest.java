package org.leo.despesas.aplicacao.grafico;

import java.text.SimpleDateFormat;

import org.junit.Test;
import org.leo.despesas.dominio.movimentacao.WrapperGraficoVO;

public class GraficoFacadeImplTest {

	@Test
	public void test() throws Exception {

		final SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

		final GraficoFacadeImpl facade = new GraficoFacadeImpl();

		final WrapperGraficoVO graficoDespesas = facade.getGraficoDespesas(format.parse("01/05/2015 00:00:00"), format.parse("30/06/2015 23:59:59"));



	}

}
