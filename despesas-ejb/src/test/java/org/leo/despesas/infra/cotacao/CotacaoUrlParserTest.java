package org.leo.despesas.infra.cotacao;

import static org.junit.Assert.*;

import java.math.BigDecimal;

import org.junit.Test;

public class CotacaoUrlParserTest {

	@Test
	public void test() throws Exception {
		
		String url = "https://economia.uol.com.br/cotacoes/cambio/euro-uniao-europeia/";

		BigDecimal cotacao = CotacaoUrlParser.getCotacao(url);
		
		assertEquals(new BigDecimal("4.35"), cotacao);

	}

}
