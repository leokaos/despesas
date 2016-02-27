package org.leo.despesas.dominio;

import static org.junit.Assert.*;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashSet;

import org.junit.Test;
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Transferencia;

public class FaturaTest {

	private final SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");

	@Test
	public void pagarTest() throws ParseException {

		CartaoCredito cartao = new CartaoCredito();
		cartao.setLimiteAtual(new BigDecimal("10000"));

		Fatura fatura = new Fatura();
		fatura.setCartao(cartao);
		fatura.setDataFechamento(format.parse("01-01-2015"));
		fatura.setDataVencimento(format.parse("01-01-2015"));
		fatura.setDespesas(new HashSet<Despesa>());

		Despesa despesa = new Despesa();
		despesa.setValor(new BigDecimal("50"));
		fatura.getDespesas().add(despesa);

		Conta conta = new Conta();
		conta.setSaldo(new BigDecimal("1000"));

		Transferencia transferencia = fatura.pagar(conta);

		assertEquals(transferencia.getDebitavel(),conta);
		assertEquals(transferencia.getCreditavel(),cartao);
		assertEquals(conta.getSaldo(),new BigDecimal("950"));

		assertEquals(transferencia.getValor(),new BigDecimal("50"));
	}

}
