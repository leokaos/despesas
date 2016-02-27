package org.leo.despesas.dominio;

import static org.apache.commons.lang3.time.DateUtils.truncate;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;

import org.junit.Test;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Receita;

public class MovimentacaoTest {

	@Test
	public final void pagarTest() {
		final Despesa despesa = new Despesa();
		final Conta conta = new Conta();
		conta.setSaldo(new BigDecimal("100.00"));

		despesa.setDebitavel(conta);
		despesa.setValor(new BigDecimal("10.00"));
		despesa.pagar();

		assertEquals(conta.getSaldo(),new BigDecimal("90.00"));
		assertEquals(truncate(despesa.getPagamento(),Calendar.DAY_OF_MONTH),truncate(new Date(),Calendar.DAY_OF_MONTH));
		assertTrue(despesa.isPaga());
	}

	@Test
	public final void depositarTest() {
		final Receita receita = new Receita();
		final Conta conta = new Conta();
		conta.setSaldo(new BigDecimal("100.00"));

		receita.setDebitavel(conta);
		receita.setValor(new BigDecimal("10.00"));

		receita.depositar();

		assertEquals(conta.getSaldo(),new BigDecimal("110.00"));
		assertEquals(truncate(receita.getPagamento(),Calendar.DAY_OF_MONTH),truncate(new Date(),Calendar.DAY_OF_MONTH));
		assertTrue(receita.isDepositado());
	}

}
