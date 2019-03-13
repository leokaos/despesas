package org.leo.despesas.dominio.movimentacao;

import static org.junit.Assert.assertEquals;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import org.junit.Test;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;

public class DespesaRecorrenteTest {
	
	private static DateFormat FORMAT = new SimpleDateFormat("yyyy-MM-dd");

	@Test
	public void deveriaRetornarUmaDespesaComBaseEmDespeaRecorrent() throws Exception {
		
		TipoDespesa tipo = new TipoDespesa();
		tipo.setId(10L);
		
		DespesaRecorrente despesaRecorrente = new DespesaRecorrente();
		despesaRecorrente.setDiaDoMes(DiaDoMes.from(5, true));
		despesaRecorrente.setTipo(tipo);
		despesaRecorrente.setValor(new BigDecimal("20.0"));
		despesaRecorrente.setDescricao("TESTE");
		
		Despesa despesa = despesaRecorrente.gerarDespesa(FORMAT.parse("2019-02-25"));
		
		assertEquals(tipo, despesa.getTipo());
		assertEquals(new BigDecimal("20.0"), despesa.getValor());
		assertEquals("2019-03-05", FORMAT.format(despesa.getVencimento()));
		assertEquals("TESTE - 05/03/2019", despesa.getDescricao());
		
	}

}
