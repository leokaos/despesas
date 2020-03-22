package org.leo.despesas.dominio.movimentacao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

import java.math.BigDecimal;

import org.junit.Test;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;
import org.leo.despesas.infra.Moeda;

public class DespesaRecorrenteTest {

	@Test
	public void testName() throws Exception {

		BigDecimal valorEsperado = new BigDecimal(20);

		TipoDespesa tipoDespesa = new TipoDespesa();
		tipoDespesa.setId(20L);

		Debitavel conta = new Conta();
		conta.setMoeda(Moeda.EURO);

		DespesaRecorrente despesaRecorrente = new DespesaRecorrente();
		despesaRecorrente.setTipoDespesa(tipoDespesa);
		despesaRecorrente.setDebitavel(conta);
		despesaRecorrente.setValor(valorEsperado);

		Despesa despesa = despesaRecorrente.gerarDespesa();

		assertEquals(despesaRecorrente.getTipoDespesa(), despesa.getTipo());
		assertEquals(Moeda.EURO, despesa.getMoeda());
		assertFalse(despesa.isPaga());
		assertEquals(valorEsperado, despesa.getValor());
	}

}
