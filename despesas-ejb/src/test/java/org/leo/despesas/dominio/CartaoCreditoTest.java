package org.leo.despesas.dominio;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.movimentacao.Despesa;

import com.google.common.collect.Lists;

public class CartaoCreditoTest {

	private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

	@Test
	public void adicionarDespesaTest() throws Exception {
		final CartaoCredito cartao = createCartaoCredito();

		final Despesa despesa = new Despesa();
		despesa.setVencimento(LocalDate.parse("29/05/2015", formatter));
		despesa.setValor(new BigDecimal("10"));

		cartao.debitar(despesa);

		final Fatura fatura = cartao.getFaturas().iterator().next();

		assertEquals(LocalDate.parse("28/06/2015", formatter), fatura.getDataFechamento());
		assertEquals(LocalDate.parse("11/07/2015", formatter), fatura.getDataVencimento());
		assertEquals(1, cartao.getFaturas().size());
		assertTrue(fatura.getDespesas().contains(despesa));
	}

	@Test
	public void adicionar2DespesasMesmaFaturaTest() throws Exception {
		final CartaoCredito cartao = createCartaoCredito();

		final Despesa despesa1 = new Despesa();
		despesa1.setVencimento(LocalDate.parse("29/05/2015", formatter));
		despesa1.setValor(new BigDecimal("10"));

		cartao.debitar(despesa1);

		final Despesa despesa2 = new Despesa();
		despesa2.setVencimento(LocalDate.parse("01/06/2015", formatter));
		despesa2.setValor(new BigDecimal("10"));

		cartao.debitar(despesa2);

		final Fatura fatura = cartao.getFaturas().iterator().next();

		assertEquals(LocalDate.parse("28/06/2015", formatter), fatura.getDataFechamento());
		assertEquals(LocalDate.parse("11/07/2015", formatter), fatura.getDataVencimento());
		assertEquals(1, cartao.getFaturas().size());
		assertEquals(2, fatura.getDespesas().size());
		assertTrue(fatura.getDespesas().contains(despesa1));
		assertTrue(fatura.getDespesas().contains(despesa2));
	}

	@Test
	public void testName() throws Exception {
		CartaoCredito cartao = createCartaoCredito();

		final Despesa despesa = new Despesa();
		despesa.setVencimento(LocalDate.parse("18/03/2020", formatter));
		despesa.setValor(new BigDecimal("10"));

		cartao.debitar(despesa);

		final Fatura fatura = cartao.getFaturas().iterator().next();

		assertEquals(LocalDate.parse("28/03/2020", formatter), fatura.getDataFechamento());
		assertEquals(LocalDate.parse("11/04/2020", formatter), fatura.getDataVencimento());
	}

	@Test
	public void bugCartaoPortoSeguroTest() throws Exception {
		CartaoCredito cartao = createCartaoCredito();

		final Despesa despesa = new Despesa();
		despesa.setVencimento(LocalDate.parse("28/03/2020", formatter));
		despesa.setValor(new BigDecimal("10"));

		cartao.debitar(despesa);

		Fatura fatura = cartao.getFaturas().iterator().next();

		assertEquals(LocalDate.parse("28/04/2020", formatter), fatura.getDataFechamento());
	}

	@Test
	public void adicionar2DespesasPeriodoDiferentesTest() throws Exception {
		final CartaoCredito cartao = createCartaoCredito();

		final Despesa despesa1 = new Despesa();
		despesa1.setVencimento(LocalDate.parse("01/06/2015", formatter));
		despesa1.setValor(new BigDecimal("10"));

		cartao.debitar(despesa1);

		final Despesa despesa2 = new Despesa();
		despesa2.setVencimento(LocalDate.parse("30/07/2015", formatter));
		despesa2.setValor(new BigDecimal("10"));

		cartao.debitar(despesa2);

		List<Fatura> faturas = Lists.newArrayList(cartao.getFaturas());

		Collections.sort(faturas, new Comparator<Fatura>() {
			@Override
			public int compare(Fatura o1, Fatura o2) {
				return o2.getDataFechamento().compareTo(o1.getDataFechamento());
			}
		});

		assertEquals(2, faturas.size());

		final Iterator<Fatura> iterator = faturas.iterator();

		final Fatura faturaAgosto = iterator.next();
		final Fatura faturaJulho = iterator.next();

		assertEquals(LocalDate.parse("28/06/2015", formatter), faturaJulho.getDataFechamento());
		assertEquals(LocalDate.parse("28/08/2015", formatter), faturaAgosto.getDataFechamento());
		assertEquals(LocalDate.parse("11/07/2015", formatter), faturaJulho.getDataVencimento());
		assertEquals(LocalDate.parse("11/09/2015", formatter), faturaAgosto.getDataVencimento());

		assertTrue(faturaJulho.getDespesas().contains(despesa1));
		assertTrue(faturaAgosto.getDespesas().contains(despesa2));
	}

	@Test
	public void deveriaAdicionarNumaUnicaFaturaTest() throws Exception {
		CartaoCredito cartao = createCartaoCredito();

		cartao.debitar(createDespesa("03/03/2023"));
		cartao.debitar(createDespesa("03/03/2023"));
		cartao.debitar(createDespesa("04/03/2023"));
		cartao.debitar(createDespesa("06/03/2023"));
		cartao.debitar(createDespesa("11/03/2023"));
		cartao.debitar(createDespesa("02/03/2023"));
		cartao.debitar(createDespesa("20/03/2023"));
		cartao.debitar(createDespesa("27/03/2023"));

		assertEquals(1, cartao.getFaturas().size());
	}

	private Despesa createDespesa(String data) {
		Despesa despesa = new Despesa();
		despesa.setVencimento(LocalDate.parse(data, formatter));
		return despesa;
	}

	protected CartaoCredito createCartaoCredito() {
		final CartaoCredito cartao = new CartaoCredito();
		cartao.setDiaDeFechamento(28);
		cartao.setDiaDeVencimento(11);
		cartao.setLimiteAtual(new BigDecimal("100"));

		return cartao;
	}
}