package org.leo.despesas.dominio;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.parcelamento.Parcelamento;
import org.leo.despesas.dominio.parcelamento.ParcelamentoAnual;
import org.leo.despesas.dominio.parcelamento.ParcelamentoMensal;
import org.leo.despesas.dominio.parcelamento.ParcelamentoSemanal;
import org.leo.despesas.dominio.parcelamento.ParcelamentoSemestral;

public class DespesaTest {

	private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

	@Test
	public void parcelamentoMensalTest() throws Exception {
		Despesa despesa = new Despesa();

		despesa.setValor(new BigDecimal("400"));
		despesa.setDescricao("despesa");
		despesa.setVencimento(LocalDate.parse("01/01/2015", formatter));

		Parcelamento parcelamento = new ParcelamentoMensal();

		List<Despesa> parcelas = parcelamento.parcelar(despesa, new BigDecimal("4"));

		assertEquals(4, parcelas.size());
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 1/4", "01/01/2015")));
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 2/4", "01/02/2015")));
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 3/4", "01/03/2015")));
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 4/4", "01/04/2015")));
	}

	@Test
	public void parcelamentoMensalComErroNoArredondamentoTest() throws Exception {
		Despesa despesa = new Despesa();

		despesa.setValor(new BigDecimal("400.01"));
		despesa.setDescricao("despesa");
		despesa.setVencimento(LocalDate.parse("01/01/2015", formatter));

		Parcelamento parcelamento = new ParcelamentoMensal();

		List<Despesa> parcelas = parcelamento.parcelar(despesa, new BigDecimal("4"));

		assertEquals(4, parcelas.size());
		assertTrue(containsDespesa(parcelas, createDespesa("100.00", "despesa 1/4", "01/01/2015")));
		assertTrue(containsDespesa(parcelas, createDespesa("100.00", "despesa 2/4", "01/02/2015")));
		assertTrue(containsDespesa(parcelas, createDespesa("100.00", "despesa 3/4", "01/03/2015")));
		assertTrue(containsDespesa(parcelas, createDespesa("100.01", "despesa 4/4", "01/04/2015")));
	}

	@Test
	public void parcelamentoSemanalTest() throws Exception {
		Despesa despesa = new Despesa();

		despesa.setValor(new BigDecimal("400"));
		despesa.setDescricao("despesa");
		despesa.setVencimento(LocalDate.parse("01/01/2015", formatter));

		Parcelamento parcelamento = new ParcelamentoSemanal();

		List<Despesa> parcelas = parcelamento.parcelar(despesa, new BigDecimal("4"));

		assertEquals(4, parcelas.size());
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 1/4", "01/01/2015")));
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 2/4", "08/01/2015")));
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 3/4", "15/01/2015")));
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 4/4", "22/01/2015")));
	}

	@Test
	public void parcelamentoSemestralTest() throws Exception {
		Despesa despesa = new Despesa();

		despesa.setValor(new BigDecimal("400"));
		despesa.setDescricao("despesa");
		despesa.setVencimento(LocalDate.parse("01/01/2015", formatter));

		Parcelamento parcelamento = new ParcelamentoSemestral();

		List<Despesa> parcelas = parcelamento.parcelar(despesa, new BigDecimal("4"));

		assertEquals(4, parcelas.size());
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 1/4", "01/01/2015")));
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 2/4", "01/07/2015")));
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 3/4", "01/01/2016")));
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 4/4", "01/07/2016")));
	}

	@Test
	public void parcelamentoAnualTest() throws Exception {
		Despesa despesa = new Despesa();

		despesa.setValor(new BigDecimal("400"));
		despesa.setDescricao("despesa");
		despesa.setVencimento(LocalDate.parse("01/01/2015", formatter));

		Parcelamento parcelamento = new ParcelamentoAnual();

		List<Despesa> parcelas = parcelamento.parcelar(despesa, new BigDecimal("4"));

		assertEquals(4, parcelas.size());
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 1/4", "01/01/2015")));
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 2/4", "01/01/2016")));
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 3/4", "01/01/2017")));
		assertTrue(containsDespesa(parcelas, createDespesa("100", "despesa 4/4", "01/01/2018")));
	}

	private Despesa createDespesa(String valor, String descricao, String vencimento) {
		Despesa despesa = new Despesa();

		despesa.setValor(new BigDecimal(valor));
		despesa.setDescricao(descricao);
		despesa.setVencimento(LocalDate.parse(vencimento, formatter));

		return despesa;
	}

	private boolean containsDespesa(List<Despesa> despesas, Despesa despesa) {

		for (Despesa d : despesas) {
			if (d.getValor().compareTo(despesa.getValor()) == 0 &&
					d.getDescricao().equals(despesa.getDescricao()) &&
					d.getVencimento().equals(despesa.getVencimento())) {
				return true;
			}
		}

		return false;
	}
}