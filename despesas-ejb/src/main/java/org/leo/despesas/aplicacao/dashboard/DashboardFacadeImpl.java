package org.leo.despesas.aplicacao.dashboard;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.leo.despesas.aplicacao.despesa.DespesaFacade;
import org.leo.despesas.aplicacao.receita.ReceitaFacade;
import org.leo.despesas.dominio.debitavel.DespesaFiltro;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.GraficoVO;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.ReceitaFiltro;

@Stateless
public class DashboardFacadeImpl implements DashboardFacade {

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	@EJB
	private DespesaFacade despesaFacade;

	@EJB
	private ReceitaFacade receitaFacade;

	@Override
	public List<GraficoVO> getExtratoMes(Date dataInicial,Date dataFinal) {

		List<GraficoVO> graficoVOs = new ArrayList<>();

		graficoVOs.add(new GraficoVO("Receitas","#42E87D",getValorTotalReceitas(dataInicial,dataFinal)));

		graficoVOs.add(new GraficoVO("Despesas","#F54047",getValorTotalDespesas(dataInicial,dataFinal)));

		return graficoVOs;
	}

	private BigDecimal getValorTotalDespesas(Date dataInicial,Date dataFinal) {

		DespesaFiltro filtroDespesa = new DespesaFiltro();

		filtroDespesa.setDataInicial(dataInicial);
		filtroDespesa.setDataFinal(dataFinal);

		BigDecimal total = BigDecimal.ZERO;

		for (Despesa despesa : despesaFacade.buscarPorFiltro(filtroDespesa)) {
			total = total.add(despesa.getValor());
		}

		return total;
	}

	private BigDecimal getValorTotalReceitas(Date dataInicial,Date dataFinal) {

		ReceitaFiltro filtroReceita = new ReceitaFiltro();

		filtroReceita.setDataInicial(dataInicial);
		filtroReceita.setDataFinal(dataFinal);

		BigDecimal total = BigDecimal.ZERO;

		for (Receita receita : receitaFacade.buscarPorFiltro(filtroReceita)) {
			total = total.add(receita.getValor());
		}

		return total;
	}

	@Override
	public BigDecimal getSaldoGeral(Date dataInicial,Date dataFinal) {
		return getValorTotalReceitas(dataInicial,dataFinal).subtract(getValorTotalDespesas(dataInicial,dataFinal));
	}

}
