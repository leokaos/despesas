package org.leo.despesas.dominio;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;

import org.junit.jupiter.api.Test;
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.infra.Moeda;

public class FaturaTest {

	private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");

	@Test
	public void pagarTest() throws Exception {

		CartaoCredito cartao = new CartaoCredito();
		cartao.setMoeda(Moeda.EURO);
		cartao.setLimiteAtual(new BigDecimal("10000"));
		cartao.setId(10L);

		Fatura fatura = new Fatura();
		fatura.setCartao(cartao);
		fatura.setDataFechamento(LocalDate.parse("01-01-2015", formatter));
		fatura.setDataVencimento(LocalDate.parse("01-01-2015", formatter));
		fatura.setDespesas(new HashSet<Despesa>());

		Despesa despesa = new Despesa();
		despesa.setValor(new BigDecimal("50"));
		fatura.getDespesas().add(despesa);

		Conta conta = new Conta();
		conta.setSaldo(new BigDecimal("1000"));
		conta.setMoeda(Moeda.EURO);
		conta.setId(20L);

		Transferencia transferencia = fatura.pagar(conta);

		assertEquals(transferencia.getDebitavel(), conta);
		assertEquals(transferencia.getCreditavel(), cartao);
		assertEquals(transferencia.getValor(), new BigDecimal("50"));
	}
}