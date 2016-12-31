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
import org.leo.despesas.aplicacao.transferencia.TransferenciaFacade;
import org.leo.despesas.dominio.debitavel.DespesaFiltro;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.GraficoVO;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.ReceitaFiltro;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.dominio.movimentacao.TransferenciaFiltro;

@Stateless
public class DashboardFacadeImpl implements DashboardFacade {

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	@EJB
	private DespesaFacade despesaFacade;

	@EJB
	private ReceitaFacade receitaFacade;

	@EJB
	private TransferenciaFacade transferenciaFacade;

	@Override
	public List<GraficoVO> getExtratoMes(final Date dataInicial,final Date dataFinal) {

		final List<GraficoVO> graficoVOs = new ArrayList<>();

		graficoVOs.add(new GraficoVO("Receitas","#42E87D",getValorTotalReceitas(dataInicial,dataFinal)));

		graficoVOs.add(new GraficoVO("Despesas","#F54047",getValorTotalDespesas(dataInicial,dataFinal)));

		graficoVOs.add(new GraficoVO("Transferências","#706EBB",getValorTotalTransferencias(dataInicial,dataFinal)));

		return graficoVOs;
	}

	private BigDecimal getValorTotalDespesas(final Date dataInicial,final Date dataFinal) {

		final DespesaFiltro filtroDespesa = new DespesaFiltro();

		filtroDespesa.setDataInicial(dataInicial);
		filtroDespesa.setDataFinal(dataFinal);

		BigDecimal total = BigDecimal.ZERO;

		for (final Despesa despesa : despesaFacade.buscarPorFiltro(filtroDespesa)) {
			total = total.add(despesa.getValor());
		}

		return total;
	}

	private BigDecimal getValorTotalTransferencias(final Date dataInicial,final Date dataFinal) {

		final TransferenciaFiltro filtroDespesa = new TransferenciaFiltro();

		filtroDespesa.setDataInicial(dataInicial);
		filtroDespesa.setDataFinal(dataFinal);

		BigDecimal total = BigDecimal.ZERO;

		for (final Transferencia tranferencia : transferenciaFacade.buscarPorFiltro(filtroDespesa)) {
			total = total.add(tranferencia.getValor());
		}

		return total;
	}

	private BigDecimal getValorTotalReceitas(final Date dataInicial,final Date dataFinal) {

		final ReceitaFiltro filtroReceita = new ReceitaFiltro();

		filtroReceita.setDataInicial(dataInicial);
		filtroReceita.setDataFinal(dataFinal);

		BigDecimal total = BigDecimal.ZERO;

		for (final Receita receita : receitaFacade.buscarPorFiltro(filtroReceita)) {
			total = total.add(receita.getValor());
		}

		return total;
	}

	@Override
	public BigDecimal getSaldoGeral(final Date dataInicial,final Date dataFinal) {
		return getValorTotalReceitas(dataInicial,dataFinal).subtract(getValorTotalDespesas(dataInicial,dataFinal)).subtract(getValorTotalTransferencias(dataInicial,dataFinal));
	}
}
