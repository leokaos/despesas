package org.leo.despesas.dominio;

import static org.hamcrest.CoreMatchers.hasItem;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.junit.Test;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.parcelamento.Parcelamento;
import org.leo.despesas.dominio.parcelamento.ParcelamentoAnual;
import org.leo.despesas.dominio.parcelamento.ParcelamentoMensal;
import org.leo.despesas.dominio.parcelamento.ParcelamentoSemanal;
import org.leo.despesas.dominio.parcelamento.ParcelamentoSemestral;

public class DespesaTest {

	private final SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

	@Test
	public void parcelamentoMensalTest() throws Exception {
		Despesa despesa = new Despesa();

		despesa.setValor(new BigDecimal("400"));
		despesa.setDescricao("despesa");
		despesa.setVencimento(dateFormat.parse("01/01/2015"));

		Parcelamento parcelamento = new ParcelamentoMensal();

		List<Despesa> parcelas = parcelamento.parcelar(despesa,new BigDecimal("4"));

		assertEquals(parcelas.size(),4);
		assertThat(parcelas,hasItem(createDespesa("100","despesa 1/4","01/01/2015")));
		assertThat(parcelas,hasItem(createDespesa("100","despesa 2/4","01/02/2015")));
		assertThat(parcelas,hasItem(createDespesa("100","despesa 3/4","01/03/2015")));
		assertThat(parcelas,hasItem(createDespesa("100","despesa 4/4","01/04/2015")));
	}

	@Test
	public void parcelamentoSemanalTest() throws Exception {
		Despesa despesa = new Despesa();

		despesa.setValor(new BigDecimal("400"));
		despesa.setDescricao("despesa");
		despesa.setVencimento(dateFormat.parse("01/01/2015"));

		Parcelamento parcelamento = new ParcelamentoSemanal();

		List<Despesa> parcelas = parcelamento.parcelar(despesa,new BigDecimal("4"));

		assertEquals(parcelas.size(),4);
		assertThat(parcelas,hasItem(createDespesa("100","despesa 1/4","01/01/2015")));
		assertThat(parcelas,hasItem(createDespesa("100","despesa 2/4","08/01/2015")));
		assertThat(parcelas,hasItem(createDespesa("100","despesa 3/4","15/01/2015")));
		assertThat(parcelas,hasItem(createDespesa("100","despesa 4/4","22/01/2015")));
	}

	@Test
	public void parcelamentoSemestralTest() throws Exception {
		Despesa despesa = new Despesa();

		despesa.setValor(new BigDecimal("400"));
		despesa.setDescricao("despesa");
		despesa.setVencimento(dateFormat.parse("01/01/2015"));

		Parcelamento parcelamento = new ParcelamentoSemestral();

		List<Despesa> parcelas = parcelamento.parcelar(despesa,new BigDecimal("4"));

		assertEquals(parcelas.size(),4);
		assertThat(parcelas,hasItem(createDespesa("100","despesa 1/4","01/01/2015")));
		assertThat(parcelas,hasItem(createDespesa("100","despesa 2/4","01/07/2015")));
		assertThat(parcelas,hasItem(createDespesa("100","despesa 3/4","01/01/2016")));
		assertThat(parcelas,hasItem(createDespesa("100","despesa 4/4","01/07/2016")));
	}

	@Test
	public void parcelamentoAnualTest() throws Exception {
		Despesa despesa = new Despesa();

		despesa.setValor(new BigDecimal("400"));
		despesa.setDescricao("despesa");
		despesa.setVencimento(dateFormat.parse("01/01/2015"));

		Parcelamento parcelamento = new ParcelamentoAnual();

		List<Despesa> parcelas = parcelamento.parcelar(despesa,new BigDecimal("4"));

		assertEquals(parcelas.size(),4);
		assertThat(parcelas,hasItem(createDespesa("100","despesa 1/4","01/01/2015")));
		assertThat(parcelas,hasItem(createDespesa("100","despesa 2/4","01/01/2016")));
		assertThat(parcelas,hasItem(createDespesa("100","despesa 3/4","01/01/2017")));
		assertThat(parcelas,hasItem(createDespesa("100","despesa 4/4","01/01/2018")));
	}

	private Despesa createDespesa(String valor,String descricao,String vencimento) throws ParseException {
		Despesa despesa = new Despesa();

		despesa.setValor(new BigDecimal(valor));
		despesa.setDescricao(descricao);
		despesa.setVencimento(dateFormat.parse(vencimento));

		return despesa;
	}

}
