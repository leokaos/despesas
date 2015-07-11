package org.leo.despesas.aplicacao.grafico;

import static org.easymock.EasyMock.expect;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.verify;
import static org.junit.Assert.assertEquals;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

<<<<<<< HEAD
import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.easymock.EasyMockRunner;
import org.easymock.Mock;
import org.easymock.MockType;
import org.easymock.TestSubject;
=======
import org.junit.Ignore;
>>>>>>> origin/master
import org.junit.Test;
import org.junit.runner.RunWith;
import org.leo.despesas.aplicacao.tipodespesa.TipoDespesaFacade;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;
import org.leo.despesas.infra.grafico.GraficoLinha;
import org.leo.despesas.infra.grafico.Serie;

<<<<<<< HEAD
@RunWith(value = EasyMockRunner.class)
=======
@Ignore
>>>>>>> origin/master
public class GraficoFacadeImplTest {

	@Mock(type = MockType.STRICT)
	private EntityManager mockEntityManager;

	@Mock(type = MockType.STRICT)
	private Query mockQuery;

	@Mock(type = MockType.STRICT)
	private TipoDespesaFacade mockTipoDespesaFacade;

	@TestSubject
	final GraficoFacade facade = new GraficoFacadeImpl();

	@Test
	public void getGraficoDespesaComUmaSerieComCincoPontosTest() throws Exception {

		final SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		final Date dataInicial = format.parse("01/05/2015 00:00:00");
		final Date dataFinal = format.parse("30/06/2015 23:59:59");

		expect(mockEntityManager.createQuery(getHQL())).andReturn(mockQuery);
		expect(mockQuery.setParameter("dataInicial", dataInicial)).andReturn(mockQuery);
		expect(mockQuery.setParameter("dataFinal", dataFinal)).andReturn(mockQuery);
		expect(mockQuery.getResultList()).andReturn(getDadosParaUmaSerieECincoPontos());
		expect(mockTipoDespesaFacade.listar()).andReturn(getListaTipoDespesa());

		replay(mockEntityManager, mockQuery, mockTipoDespesaFacade);

		final GraficoLinha grafico = facade.getGraficoDespesas(dataInicial, dataFinal);

		verify(mockEntityManager, mockQuery, mockTipoDespesaFacade);

		assertEquals(grafico.getSeries().size(), 1);
		assertEquals(grafico.getSeries().iterator().next().getPontos().size(), 5);

	}

	@Test
	public void getGraficoDespesaComDuasSerieComTresPontosTest() throws Exception {

		final SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		final Date dataInicial = format.parse("01/05/2015 00:00:00");
		final Date dataFinal = format.parse("30/06/2015 23:59:59");

		expect(mockEntityManager.createQuery(getHQL())).andReturn(mockQuery);
		expect(mockQuery.setParameter("dataInicial", dataInicial)).andReturn(mockQuery);
		expect(mockQuery.setParameter("dataFinal", dataFinal)).andReturn(mockQuery);
		expect(mockQuery.getResultList()).andReturn(getDadosParaDuasSerieTresPontos());
		expect(mockTipoDespesaFacade.listar()).andReturn(getListaTipoDespesa());

		replay(mockEntityManager, mockQuery, mockTipoDespesaFacade);

		final GraficoLinha grafico = facade.getGraficoDespesas(dataInicial, dataFinal);

		verify(mockEntityManager, mockQuery, mockTipoDespesaFacade);

		assertEquals(grafico.getSeries().size(), 2);

		final Iterator<Serie> iterator = grafico.getSeries().iterator();

		while (iterator.hasNext()) {
			assertEquals(iterator.next().getPontos().size(), 3);
		}

	}

	private String getHQL() {
		return "SELECT d.tipo.descricao , MONTH(d.pagamento) , YEAR(d.pagamento) , SUM(d.valor) FROM Despesa d "
				+ "WHERE d.pagamento BETWEEN :dataInicial AND :dataFinal " + "GROUP BY d.tipo.descricao , MONTH(d.pagamento) , YEAR(d.pagamento)"
				+ " ORDER BY d.tipo.descricao , YEAR(d.pagamento) , MONTH(d.pagamento) ";
	}

	private List<Object[]> getDadosParaDuasSerieTresPontos() {
		final List<Object[]> lista = new ArrayList<Object[]>();

		lista.add(new Object[] { "Carro", 1, 2015, 100 });
		lista.add(new Object[] { "Carro", 2, 2015, 200 });
		lista.add(new Object[] { "Carro", 3, 2015, 300 });

		lista.add(new Object[] { "Comida", 1, 2015, 400 });
		lista.add(new Object[] { "Comida", 2, 2015, 500 });
		lista.add(new Object[] { "Comida", 3, 2015, 600 });

		return lista;
	}

	private List<Object[]> getDadosParaUmaSerieECincoPontos() {
		final List<Object[]> lista = new ArrayList<Object[]>();

		lista.add(new Object[] { "Carro", 1, 2015, 100 });
		lista.add(new Object[] { "Carro", 2, 2015, 200 });
		lista.add(new Object[] { "Carro", 3, 2015, 300 });
		lista.add(new Object[] { "Carro", 4, 2015, 400 });
		lista.add(new Object[] { "Carro", 5, 2015, 500 });

		return lista;
	}

	private List<TipoDespesa> getListaTipoDespesa() {
		final TipoDespesa tipoDespesaCarro = new TipoDespesa();
		tipoDespesaCarro.setDescricao("Carro");
		tipoDespesaCarro.setCor("#000");

		final TipoDespesa tipoDespesaComida = new TipoDespesa();
		tipoDespesaComida.setDescricao("Comida");
		tipoDespesaComida.setCor("#F00");

		return Arrays.asList(tipoDespesaCarro, tipoDespesaComida);
	}
}
