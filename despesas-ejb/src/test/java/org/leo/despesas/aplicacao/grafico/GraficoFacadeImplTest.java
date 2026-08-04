package org.leo.despesas.aplicacao.grafico;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.leo.despesas.aplicacao.tipodespesa.TipoDespesaFacade;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesaFiltro;
import org.leo.despesas.infra.Moeda;
import org.leo.despesas.infra.grafico.GraficoLinha;
import org.leo.despesas.infra.grafico.Serie;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class GraficoFacadeImplTest {

	@Mock
	private EntityManager mockEntityManager;

	@Mock
	private Query mockQuery;

	@Mock
	private TipoDespesaFacade mockTipoDespesaFacade;

	@InjectMocks
	private GraficoFacadeImpl facade = new GraficoFacadeImpl();

	@Test
	public void getGraficoDespesaComUmaSerieComCincoPontosTest() throws Exception {

		final SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		final Date dataInicial = format.parse("01/05/2015 00:00:00");
		final Date dataFinal = format.parse("30/06/2015 23:59:59");

		when(mockEntityManager.createQuery(getHQL())).thenReturn(mockQuery);
		when(mockQuery.setParameter("dataInicial", dataInicial)).thenReturn(mockQuery);
		when(mockQuery.setParameter("dataFinal", dataFinal)).thenReturn(mockQuery);
		when(mockQuery.setParameter("moeda", Moeda.EURO)).thenReturn(mockQuery);
		when(mockQuery.getResultList()).thenReturn(getDadosParaUmaSerieECincoPontos());
		when(mockTipoDespesaFacade.listar(any(TipoDespesaFiltro.class))).thenReturn(getListaTipoDespesa());

		final GraficoLinha grafico = facade.getGraficoDespesas(dataInicial, dataFinal);

		verify(mockEntityManager).createQuery(getHQL());
		verify(mockQuery).setParameter("dataInicial", dataInicial);
		verify(mockQuery).setParameter("dataFinal", dataFinal);
		verify(mockQuery).setParameter("moeda", Moeda.EURO);
		verify(mockQuery).getResultList();
		verify(mockTipoDespesaFacade).listar(any(TipoDespesaFiltro.class));

		assertEquals(1, grafico.getSeries().size());
		assertEquals(5, grafico.getSeries().iterator().next().getPontos().size());

	}

	@Test
	public void getGraficoDespesaComDuasSerieComTresPontosTest() throws Exception {

		final SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		final Date dataInicial = format.parse("01/05/2015 00:00:00");
		final Date dataFinal = format.parse("30/06/2015 23:59:59");

		when(mockEntityManager.createQuery(getHQL())).thenReturn(mockQuery);
		when(mockQuery.setParameter("dataInicial", dataInicial)).thenReturn(mockQuery);
		when(mockQuery.setParameter("dataFinal", dataFinal)).thenReturn(mockQuery);
		when(mockQuery.setParameter("moeda", Moeda.EURO)).thenReturn(mockQuery);
		when(mockQuery.getResultList()).thenReturn(getDadosParaDuasSerieTresPontos());
		when(mockTipoDespesaFacade.listar(any(TipoDespesaFiltro.class))).thenReturn(getListaTipoDespesa());

		final GraficoLinha grafico = facade.getGraficoDespesas(dataInicial, dataFinal);

		verify(mockEntityManager).createQuery(getHQL());
		verify(mockQuery).setParameter("dataInicial", dataInicial);
		verify(mockQuery).setParameter("dataFinal", dataFinal);
		verify(mockQuery).setParameter("moeda", Moeda.EURO);
		verify(mockQuery).getResultList();
		verify(mockTipoDespesaFacade).listar(any(TipoDespesaFiltro.class));

		assertEquals(2, grafico.getSeries().size());

		final Iterator<Serie> iterator = grafico.getSeries().iterator();

		while (iterator.hasNext()) {
			assertEquals(3, iterator.next().getPontos().size());
		}

	}

	private String getHQL() {
		StringBuilder builder = new StringBuilder();

		builder.append("SELECT d.tipo.descricao , MONTH(d.vencimento) , YEAR(d.vencimento) , SUM(d.valor) FROM Despesa d ");
		builder.append("WHERE d.vencimento BETWEEN :dataInicial AND :dataFinal AND d.moeda = :moeda ");
		builder.append("GROUP BY d.tipo.descricao , MONTH(d.vencimento) , YEAR(d.vencimento) ");
		builder.append("ORDER BY d.tipo.descricao , YEAR(d.vencimento) , MONTH(d.vencimento)");

		return builder.toString();
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
