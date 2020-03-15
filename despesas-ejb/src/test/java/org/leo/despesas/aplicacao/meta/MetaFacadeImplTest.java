package org.leo.despesas.aplicacao.meta;

import static org.easymock.EasyMock.expect;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.verify;
import static org.junit.Assert.assertEquals;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import org.apache.commons.lang3.time.DateUtils;
import org.easymock.EasyMockRunner;
import org.easymock.Mock;
import org.easymock.MockType;
import org.easymock.TestSubject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.leo.despesas.aplicacao.movimentacao.MovimentacaoFacade;
import org.leo.despesas.dominio.meta.Meta;
import org.leo.despesas.dominio.meta.MetaFiltro;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Movimentacao;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.infra.Periodo;

import com.google.common.collect.Lists;

@RunWith(value = EasyMockRunner.class)
public class MetaFacadeImplTest {

	@Mock(type = MockType.STRICT)
	private EntityManager mockEntityManager;

	@Mock(type = MockType.STRICT)
	private TypedQuery<Meta> mockQuery;

	@Mock(type = MockType.STRICT)
	private MovimentacaoFacade mockMovimentacaoFacade;

	@TestSubject
	final MetaFacade facade = new MetaFacadeImpl();

	@Test
	public void test() {

		MetaFiltro filtro = new MetaFiltro();

		List<Meta> expectedLista = Lists.newArrayList();

		List<Movimentacao> movimentacaoEsperada = Lists.newArrayList(createDespesa(20.0), createReceita(40.0));

		Meta meta = new Meta();

		Date dataInicial = DateUtils.addDays(new Date(), -10);
		Date dataFinal = DateUtils.addDays(new Date(), 20);

		meta.setPeriodo(new Periodo(dataInicial, dataFinal));

		expectedLista.add(meta);

		expect(mockEntityManager.createQuery("SELECT meta FROM Meta meta", Meta.class)).andReturn(mockQuery);
		expect(mockQuery.getResultList()).andReturn(expectedLista);
		expect(mockMovimentacaoFacade.buscarMovimentacaoPorPeriodo(dataInicial, dataFinal)).andReturn(movimentacaoEsperada);

		replayAll();

		List<Meta> resultado = facade.listar(filtro);

		verifyAll();

		Meta metaResultado = resultado.iterator().next();

		assertEquals(new BigDecimal(1), metaResultado.getValorDiario());
	}

	private Movimentacao createDespesa(double valor) {

		Despesa despesa = new Despesa();

		despesa.setValor(new BigDecimal(valor));

		return despesa;
	}

	private Movimentacao createReceita(double valor) {

		Receita receita = new Receita();

		receita.setValor(new BigDecimal(valor));

		return receita;
	}

	private void verifyAll() {
		verify(mockEntityManager, mockQuery, mockMovimentacaoFacade);
	}

	private void replayAll() {
		replay(mockEntityManager, mockQuery, mockMovimentacaoFacade);
	}

}
