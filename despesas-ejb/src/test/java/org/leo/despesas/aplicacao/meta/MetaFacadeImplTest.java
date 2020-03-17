package org.leo.despesas.aplicacao.meta;

import static org.easymock.EasyMock.expect;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.verify;
import static org.junit.Assert.assertEquals;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

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
import org.leo.despesas.infra.Mes;
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
	public void deveriaRetornarValorDiarioEsperadoTest() throws Exception {

		MetaFiltro filtro = new MetaFiltro();

		List<Meta> expectedLista = Lists.newArrayList();

		List<Movimentacao> movimentacaoEsperada = Lists.newArrayList(createDespesa(2000.0), createReceita(4000.0));

		Meta meta = new Meta();

		meta.setMes(new Mes(new Date()));
		meta.setValor(new BigDecimal(200));

		Periodo periodo = meta.getMes().getPeriodo();

		Date dataInicial = periodo.getDataInicial();
		Date dataFinal = periodo.getDataFinal();

		expectedLista.add(meta);

		BigDecimal valorEsperado = new BigDecimal(1800).divide(new BigDecimal(periodo.getDiasParaTermino()), 2, RoundingMode.HALF_UP);

		expect(mockEntityManager.createQuery("SELECT meta FROM Meta meta", Meta.class)).andReturn(mockQuery);
		expect(mockQuery.getResultList()).andReturn(expectedLista);
		expect(mockMovimentacaoFacade.buscarMovimentacaoPorPeriodo(dataInicial, dataFinal)).andReturn(movimentacaoEsperada);

		replayAll();

		List<Meta> resultado = facade.listar(filtro);

		verifyAll();

		Meta metaResultado = resultado.iterator().next();

		assertEquals(valorEsperado, metaResultado.getValorDiario());
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
