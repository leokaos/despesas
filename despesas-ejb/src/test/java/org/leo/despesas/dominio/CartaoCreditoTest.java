package org.leo.despesas.dominio;

import static org.hamcrest.CoreMatchers.hasItem;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;

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
		final CartaoCredito cartao = createCartaoCredito();

		final Despesa despesa = new Despesa();
		despesa.setVencimento(formatter.parse("29/05/2015"));
		despesa.setValor(new BigDecimal("10"));

		cartao.debitar(despesa);

		final Fatura fatura = cartao.getFaturas().iterator().next();

		assertEquals(formatter.format(fatura.getDataFechamento()), "28/06/2015");
		assertEquals(formatter.format(fatura.getDataVencimento()), "11/07/2015");
		assertEquals(cartao.getFaturas().size(), 1);
		assertThat(fatura.getDespesas(), hasItem(despesa));
	}

	@Test
	public void adicionar2DespesasMesmaFaturaTest() throws Exception {
		final CartaoCredito cartao = createCartaoCredito();

		final Despesa despesa1 = new Despesa();
		despesa1.setVencimento(formatter.parse("29/05/2015"));
		despesa1.setValor(new BigDecimal("10"));

		cartao.debitar(despesa1);

		final Despesa despesa2 = new Despesa();
		despesa2.setVencimento(formatter.parse("01/06/2015"));
		despesa2.setValor(new BigDecimal("10"));

		cartao.debitar(despesa2);

		final Fatura fatura = cartao.getFaturas().iterator().next();

		assertEquals(formatter.format(fatura.getDataFechamento()), "28/06/2015");
		assertEquals(formatter.format(fatura.getDataVencimento()), "11/07/2015");
		assertEquals(cartao.getFaturas().size(), 1);
		assertEquals(fatura.getDespesas().size(), 2);
		assertThat(fatura.getDespesas(), hasItem(despesa1));
		assertThat(fatura.getDespesas(), hasItem(despesa2));
	}

	@Test
	public void adicionar2DespesasPeriodoDiferentesTest() throws Exception {
		final CartaoCredito cartao = createCartaoCredito();

		final Despesa despesa1 = new Despesa();
		despesa1.setVencimento(formatter.parse("01/06/2015"));
		despesa1.setValor(new BigDecimal("10"));

		cartao.debitar(despesa1);

		final Despesa despesa2 = new Despesa();
		despesa2.setVencimento(formatter.parse("30/07/2015"));
		despesa2.setValor(new BigDecimal("10"));

		cartao.debitar(despesa2);

		assertEquals(cartao.getFaturas().size(), 2);
		final Fatura faturaJulho = cartao.getFaturas().get(0);
		final Fatura faturaAgosto = cartao.getFaturas().get(1);

		assertEquals(faturaJulho.getDataFechamento(), formatter.parse("28/06/2015"));
		assertEquals(faturaAgosto.getDataFechamento(), formatter.parse("28/08/2015"));

		assertEquals(faturaJulho.getDataVencimento(),  formatter.parse("11/07/2015"));
		assertEquals(faturaAgosto.getDataVencimento(), formatter.parse("11/09/2015"));

		assertThat(faturaJulho.getDespesas(), hasItem(despesa1));
		assertThat(faturaAgosto.getDespesas(), hasItem(despesa2));
	}

	protected CartaoCredito createCartaoCredito() {
		final CartaoCredito cartao = new CartaoCredito();
		cartao.setDiaDeFechamento(28);
		cartao.setDiaDeVencimento(11);
		cartao.setLimiteAtual(new BigDecimal("100"));

		return cartao;
	}
}
