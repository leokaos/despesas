package org.leo.despesas.aplicacao.debitavel;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.leo.despesas.aplicacao.despesa.DespesaFacade;
import org.leo.despesas.aplicacao.receita.ReceitaFacade;
import org.leo.despesas.aplicacao.transferencia.TransferenciaFacade;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.DespesaFiltro;
import org.leo.despesas.dominio.movimentacao.Movimentacao;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.ReceitaFiltro;
import org.leo.despesas.dominio.movimentacao.TransferenciaFiltro;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.google.common.collect.Lists;

@ExtendWith(MockitoExtension.class)
class DebitavelFacadeImplTest {

	private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");

	@InjectMocks
	private DebitavelFacade facade = new DebitavelFacadeImpl();

	@Mock
	private DespesaFacade mockDespesaFacade;

	@Mock
	private ReceitaFacade mockReceitaFacade;

	@Mock
	private TransferenciaFacade mockTransferenciaFacade;

	@Test
	void test() throws Exception {
		Debitavel debitavel = new Conta();
		debitavel.setId(10L);

		ArgumentCaptor<DespesaFiltro> captureDespesaFiltro = ArgumentCaptor.forClass(DespesaFiltro.class);
		ArgumentCaptor<ReceitaFiltro> captureReceitaFiltro = ArgumentCaptor.forClass(ReceitaFiltro.class);

		when(mockDespesaFacade.listar(captureDespesaFiltro.capture())).thenReturn(createListaDeDespesas());
		when(mockReceitaFacade.listar(captureReceitaFiltro.capture())).thenReturn(createListaDeReceita());
		when(mockTransferenciaFacade.listar(any(TransferenciaFiltro.class))).thenReturn(Lists.newArrayList());

		BigDecimal mediaVariacao = facade.getMediaVariacao(debitavel);

		verify(mockTransferenciaFacade, times(2)).listar(any(TransferenciaFiltro.class));
		assertEquals(new BigDecimal("56.00"), mediaVariacao);
	}

	private List<Despesa> createListaDeDespesas() throws Exception {
		return Lists.newArrayList(createDespesa(20.0, "01/01/2019"), createDespesa(40.0, "01/05/2019"));
	}

	private List<Receita> createListaDeReceita() throws Exception {
		return Lists.newArrayList(createReceita(200.0, "05/01/2019"), createReceita(140.0, "05/05/2019"));
	}

	private Despesa createDespesa(double valor, String date) throws Exception {
		return (Despesa) setValues(valor, date, new Despesa());
	}

	private Receita createReceita(double valor, String date) throws Exception {
		return (Receita) setValues(valor, date, new Receita());
	}

	private Movimentacao setValues(double valor, String date, Movimentacao mov) throws Exception {
		mov.setValor(new BigDecimal(valor));
		mov.setVencimento(DATE_FORMAT.parse(date));
		return mov;
	}
}