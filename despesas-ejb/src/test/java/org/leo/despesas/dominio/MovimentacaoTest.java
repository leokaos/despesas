package org.leo.despesas.dominio;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.time.LocalDate;

import org.junit.jupiter.api.Test;
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

		assertEquals(new BigDecimal("90.00"), conta.getSaldo());
		assertEquals(LocalDate.now(), despesa.getPagamento());
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

		assertEquals(new BigDecimal("110.00"), conta.getSaldo());
		assertEquals(LocalDate.now(), receita.getPagamento());
		assertTrue(receita.isDepositado());
	}
}