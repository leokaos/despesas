package org.leo.despesas.dominio;

import static org.junit.Assert.assertEquals;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;

import org.junit.Test;
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.movimentacao.Despesa;

public class CartaoCreditoTest {

	private final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

	@Test
	public void adicionarDespesaTest() throws Exception {
		CartaoCredito cartao = createCartaoCredito();

		Despesa despesa = new Despesa();
		despesa.setVencimento(formatter.parse("10/02/2015"));
		despesa.setValor(new BigDecimal("10"));

		cartao.debitar(despesa);

		Fatura fatura = cartao.getFaturas().iterator().next();

		assertEquals(formatter.format(fatura.getDataFechamento()),"28/02/2015");
		assertEquals(formatter.format(fatura.getDataVencimento()),"11/03/2015");
		assertEquals(cartao.getFaturas().size(),1);
	}

	@Test
	public void adicionar2DespesasMesmaFaturaTest() throws Exception {
		CartaoCredito cartao = createCartaoCredito();

		Despesa despesa1 = new Despesa();
		despesa1.setVencimento(formatter.parse("12/02/2015"));
		despesa1.setValor(new BigDecimal("10"));

		cartao.debitar(despesa1);

		Despesa despesa2 = new Despesa();
		despesa2.setVencimento(formatter.parse("01/02/2015"));
		despesa2.setValor(new BigDecimal("10"));

		cartao.debitar(despesa2);

		Fatura fatura = cartao.getFaturas().iterator().next();

		assertEquals(formatter.format(fatura.getDataFechamento()),"28/02/2015");
		assertEquals(formatter.format(fatura.getDataVencimento()),"11/03/2015");
		assertEquals(cartao.getFaturas().size(),1);
		assertEquals(fatura.getDespesas().size(),2);
	}

	@Test
	public void adicionar2DespesasPeriodoDiferentesTest() throws Exception {
		CartaoCredito cartao = createCartaoCredito();

		Despesa despesa1 = new Despesa();
		despesa1.setVencimento(formatter.parse("12/02/2015"));
		despesa1.setValor(new BigDecimal("10"));

		cartao.debitar(despesa1);

		Despesa despesa2 = new Despesa();
		despesa2.setVencimento(formatter.parse("25/03/2015"));
		despesa2.setValor(new BigDecimal("10"));

		cartao.debitar(despesa2);

		assertEquals(cartao.getFaturas().size(),2);
	}

	protected CartaoCredito createCartaoCredito() {
		CartaoCredito cartao = new CartaoCredito();
		cartao.setDiaDeFechamento(28);
		cartao.setDiaDeVencimento(11);
		cartao.setLimiteAtual(new BigDecimal("100"));

		return cartao;
	}
}
