package org.leo.despesas.dominio;

import static org.hamcrest.CoreMatchers.hasItem;
import static org.junit.Assert.*;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang3.time.DateUtils;
import org.junit.Test;
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.movimentacao.Despesa;

import com.google.common.collect.Lists;

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

		assertEquals(formatter.format(fatura.getDataFechamento()), "27/06/2015");
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

		assertEquals(formatter.format(fatura.getDataFechamento()), "27/06/2015");
		assertEquals(formatter.format(fatura.getDataVencimento()), "11/07/2015");
		assertEquals(cartao.getFaturas().size(), 1);
		assertEquals(fatura.getDespesas().size(), 2);
		assertThat(fatura.getDespesas(), hasItem(despesa1));
		assertThat(fatura.getDespesas(), hasItem(despesa2));
	}

	@Test
	public void testName() throws Exception {

		CartaoCredito cartao = createCartaoCredito();

		final Despesa despesa = new Despesa();
		despesa.setVencimento(formatter.parse("18/03/2020"));
		despesa.setValor(new BigDecimal("10"));

		cartao.debitar(despesa);

		final Fatura fatura = cartao.getFaturas().iterator().next();

		assertEquals(formatter.format(fatura.getDataFechamento()), "27/03/2020");
		assertEquals(formatter.format(fatura.getDataVencimento()), "11/04/2020");
	}

	@Test
	public void bugCartaoPortoSeguroTest() throws Exception {

		CartaoCredito cartao = createCartaoCredito();

		final Despesa despesa = new Despesa();
		despesa.setVencimento(formatter.parse("27/03/2020"));
		despesa.setValor(new BigDecimal("10"));

		cartao.debitar(despesa);

		Fatura fatura = cartao.getFaturas().iterator().next();

		assertEquals(formatter.parse("27/04/2020"), fatura.getDataFechamento());
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

		List<Fatura> faturas = Lists.newArrayList(cartao.getFaturas());

		Collections.sort(faturas, new Comparator<Fatura>() {

			@Override
			public int compare(Fatura o1, Fatura o2) {
				return o2.getDataFechamento().compareTo(o1.getDataFechamento());
			}
		});

		assertEquals(faturas.size(), 2);

		final Iterator<Fatura> iterator = faturas.iterator();

		final Fatura faturaAgosto = iterator.next();
		final Fatura faturaJulho = iterator.next();

		assertEquals(faturaJulho.getDataFechamento(), formatter.parse("27/06/2015"));
		assertEquals(faturaAgosto.getDataFechamento(), formatter.parse("27/08/2015"));

		assertEquals(faturaJulho.getDataVencimento(), formatter.parse("11/07/2015"));
		assertEquals(faturaAgosto.getDataVencimento(), formatter.parse("11/09/2015"));

		assertThat(faturaJulho.getDespesas(), hasItem(despesa1));
		assertThat(faturaAgosto.getDespesas(), hasItem(despesa2));
	}

	@Test
	public void deveria() throws Exception {

		CartaoCredito cartao = createCartaoCredito();

		Fatura faturaMarco = new Fatura();
		faturaMarco.setDataFechamento(formatter.parse("27/03/2020"));
		cartao.getFaturas().add(faturaMarco);

		Fatura faturaAbril = new Fatura();
		faturaAbril.setDataFechamento(formatter.parse("27/04/2020"));
		cartao.getFaturas().add(faturaAbril);

		Date dataBase = DateUtils.addHours(formatter.parse("27/03/2020"), 1);

		Fatura fatura = cartao.getFaturaPorData(dataBase);

		assertEquals(formatter.parse("27/04/2020"), fatura.getDataFechamento());

	}

	protected CartaoCredito createCartaoCredito() {
		final CartaoCredito cartao = new CartaoCredito();
		cartao.setDiaDeFechamento(27);
		cartao.setDiaDeVencimento(11);
		cartao.setLimiteAtual(new BigDecimal("100"));

		return cartao;
	}
}
