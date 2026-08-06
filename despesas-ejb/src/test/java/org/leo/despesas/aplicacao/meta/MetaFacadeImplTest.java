package org.leo.despesas.aplicacao.meta;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.leo.despesas.aplicacao.movimentacao.MovimentacaoFacade;
import org.leo.despesas.dominio.meta.Meta;
import org.leo.despesas.dominio.meta.MetaFiltro;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Movimentacao;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.infra.Mes;
import org.leo.despesas.infra.Periodo;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.google.common.collect.Lists;

@ExtendWith(MockitoExtension.class)
public class MetaFacadeImplTest {

	@Mock
	private EntityManager mockEntityManager;

	@Mock
	private TypedQuery<Meta> mockQuery;

	@Mock
	private MovimentacaoFacade mockMovimentacaoFacade;

	@InjectMocks
	private MetaFacadeImpl facade = new MetaFacadeImpl();

	@Test
	public void deveriaRetornarValorDiarioEsperadoTest() throws Exception {

		MetaFiltro filtro = new MetaFiltro();

		List<Meta> expectedLista = Lists.newArrayList();

		List<Movimentacao> movimentacaoEsperada = Lists.newArrayList(createDespesa(2000.0), createReceita(4000.0));

		Meta meta = new Meta();

		meta.setMes(new Mes(LocalDate.now()));
		meta.setValor(new BigDecimal(200));

		Periodo periodo = meta.getMes().getPeriodo();

		LocalDate dataInicial = periodo.getDataInicial();
		LocalDate dataFinal = periodo.getDataFinal();

		expectedLista.add(meta);

		BigDecimal valorEsperado = new BigDecimal(1800)
				.divide(new BigDecimal(periodo.getDiasParaTermino()), 2, RoundingMode.HALF_UP);

		when(mockEntityManager.createQuery("SELECT meta FROM Meta meta ORDER BY meta.id", Meta.class))
				.thenReturn(mockQuery);
		when(mockQuery.getResultList()).thenReturn(expectedLista);
		when(mockMovimentacaoFacade.buscarMovimentacaoPorPeriodo(dataInicial, dataFinal))
				.thenReturn(movimentacaoEsperada);

		List<Meta> resultado = facade.listar(filtro);

		verify(mockEntityManager).createQuery("SELECT meta FROM Meta meta ORDER BY meta.id", Meta.class);
		verify(mockQuery).getResultList();
		verify(mockMovimentacaoFacade).buscarMovimentacaoPorPeriodo(dataInicial, dataFinal);

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
}