package org.leo.despesas.dominio.servicotransferencia;

import static org.junit.Assert.assertEquals;

import java.math.BigDecimal;

import org.junit.Test;

public class ServicoTransferenciaTest {

	@Test
	public void deveriaRetornarValorDaTransferenciaTest() throws Exception {

		ServicoTransferencia servico = new ServicoTransferencia();
		servico.setSpred(new BigDecimal("2.0"));
		servico.setTaxas(new BigDecimal("160.00"));

		Cotacao cotacao = new Cotacao();
		cotacao.setTaxa(new BigDecimal("4.3451"));

		BigDecimal spot = new BigDecimal(0.003);
		BigDecimal valor = new BigDecimal("2629.95");

		Porcentagem iof = Porcentagem.from(0.38);

		double valorTotal = servico.calcularValorParaTransferencia(cotacao, spot, iof, valor);

		assertEquals(11001.01, valorTotal, 0.0);
	}

}
