package org.leo.despesas.dominio;

import static org.junit.Assert.assertEquals;

import java.text.SimpleDateFormat;

import org.junit.Test;
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.movimentacao.Despesa;

public class CartaoCreditoTest {

	private SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

	@Test
	public void adicionarDespesaTest() throws Exception {
		CartaoCredito cartao = new CartaoCredito();
		cartao.setDiaDeFechamento(28);
		cartao.setDiaDeVencimento(11);

		Despesa despesa = new Despesa();
		despesa.setVencimento(formatter.parse("10/02/2015"));

		cartao.debitar(despesa);

		Fatura fatura = cartao.getFaturas().iterator().next();

		assertEquals(formatter.format(fatura.getDataFechamento()), "28/02/2015");
		assertEquals(formatter.format(fatura.getDataVencimento()), "11/03/2015");
	}
}
