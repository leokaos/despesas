package org.leo.despesas.test;

import static org.apache.commons.lang3.time.DateUtils.truncate;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;

import org.junit.Test;
import org.leo.despesas.dominio.Conta;
import org.leo.despesas.dominio.Despesa;
import org.leo.despesas.dominio.Receita;

public class MovimentacaoTest {

	@Test
	public final void pagarTest() {
		final Despesa despesa = createDespesa();

		despesa.getConta().setSaldo(new BigDecimal("100.00"));
		despesa.setValor(new BigDecimal("10.00"));

		despesa.pagar();

		assertEquals(despesa.getConta().getSaldo(), new BigDecimal("90.00"));
		assertEquals(truncate(despesa.getPagamento(), Calendar.DAY_OF_MONTH), truncate(new Date(), Calendar.DAY_OF_MONTH));
		assertTrue(despesa.isPaga());
	}

	@Test
	public final void depositarTest() {
		final Receita despesa = createReceita();

		despesa.getConta().setSaldo(new BigDecimal("100.00"));
		despesa.setValor(new BigDecimal("10.00"));

		despesa.depositar();

		assertEquals(despesa.getConta().getSaldo(), new BigDecimal("110.00"));
		assertEquals(truncate(despesa.getPagamento(), Calendar.DAY_OF_MONTH), truncate(new Date(), Calendar.DAY_OF_MONTH));
		assertTrue(despesa.isDepositado());
	}

	private Despesa createDespesa() {
		final Despesa despesa = new Despesa();
		despesa.setConta(new Conta());

		return despesa;
	}

	private Receita createReceita() {
		final Receita receita = new Receita();
		receita.setConta(new Conta());

		return receita;
	}

}
