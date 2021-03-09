package org.leo.despesas.aplicacao.debitavel;

import static org.easymock.EasyMock.anyObject;
import static org.easymock.EasyMock.capture;
import static org.easymock.EasyMock.expect;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.verify;
import static org.junit.Assert.assertEquals;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.easymock.Capture;
import org.easymock.EasyMockRunner;
import org.easymock.Mock;
import org.easymock.MockType;
import org.easymock.TestSubject;
import org.junit.Test;
import org.junit.runner.RunWith;
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
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.dominio.movimentacao.TransferenciaFiltro;

import com.google.common.collect.Lists;

@RunWith(EasyMockRunner.class)
public class DebitavelFacadeImplTest {

	private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");

	@TestSubject
	private DebitavelFacade facade = new DebitavelFacadeImpl();

	@Mock(type = MockType.STRICT)
	private DespesaFacade mockDespesaFacade;

	@Mock(type = MockType.STRICT)
	private ReceitaFacade mockReceitaFacade;

	@Mock(type = MockType.STRICT)
	private TransferenciaFacade mockTransferenciaFacade;

	@Test
	public void test() throws Exception {

		Debitavel debitavel = new Conta();
		debitavel.setId(10L);

		Capture<DespesaFiltro> captureDespesaFiltro = new Capture<DespesaFiltro>();
		Capture<ReceitaFiltro> captureReceitaFiltro = new Capture<ReceitaFiltro>();

		expect(mockDespesaFacade.listar(capture(captureDespesaFiltro))).andReturn(createListaDeDespesas());
		expect(mockReceitaFacade.listar(capture(captureReceitaFiltro))).andReturn(createListaDeReceita());

		expect(mockTransferenciaFacade.listar(anyObject(TransferenciaFiltro.class))).andReturn(Lists.<Transferencia>newArrayList()).times(2);

		replay(mockDespesaFacade, mockReceitaFacade, mockTransferenciaFacade);

		BigDecimal mediaVariacao = facade.getMediaVariacao(debitavel);

		verify(mockDespesaFacade, mockReceitaFacade, mockTransferenciaFacade);

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

	private Movimentacao setValues(double valor, String date, Movimentacao mov) throws ParseException {
		mov.setValor(new BigDecimal(valor));
		mov.setVencimento(DATE_FORMAT.parse(date));
		return mov;
	}

}
