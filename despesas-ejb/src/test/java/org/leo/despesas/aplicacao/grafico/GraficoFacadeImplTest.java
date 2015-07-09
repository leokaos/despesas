package org.leo.despesas.aplicacao.grafico;

import static org.junit.Assert.assertEquals;

import java.text.SimpleDateFormat;

import org.junit.Test;
import org.leo.despesas.infra.grafico.GraficoLinha;

public class GraficoFacadeImplTest {

	@Test
	public void test() throws Exception {

		final SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

		final GraficoFacadeImpl facade = new GraficoFacadeImpl();

		GraficoLinha grafico = facade.getGraficoDespesas(format.parse("01/05/2015 00:00:00"),format.parse("30/06/2015 23:59:59"));

		assertEquals(grafico.getSeries().size(),3);

	}

}
