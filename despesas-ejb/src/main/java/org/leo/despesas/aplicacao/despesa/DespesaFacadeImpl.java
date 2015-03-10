package org.leo.despesas.aplicacao.despesa;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.Query;

import org.leo.despesas.aplicacao.conta.ContaFacade;
import org.leo.despesas.dominio.GraficoVO;
import org.leo.despesas.dominio.debitavel.DespesaFiltro;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.parcelamento.Parcelamento;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.DataUtil;
import org.leo.despesas.infra.Periodo;

@Stateless
public class DespesaFacadeImpl extends AbstractFacade<Despesa> implements DespesaFacade {

	@EJB
	private ContaFacade contaFacade;

	@Override
	@SuppressWarnings("unchecked")
	public List<GraficoVO> getGraficoPorPeriodo(Periodo periodo) {
		StringBuilder builder = new StringBuilder();

		builder.append("SELECT NEW org.leo.despesas.dominio.GraficoVO(d.tipoDespesa.descricao,d.tipoDespesa.cor, SUM(d.valor)) FROM Despesa d ");
		builder.append("WHERE d.vencimento BETWEEN :dataInicial AND :dataFinal ");
		builder.append("GROUP BY d.tipoDespesa.descricao, d.tipoDespesa.cor");

		Query query = entityManager.createQuery(builder.toString());

		query.setParameter("dataInicial", periodo.getDataInicial());
		query.setParameter("dataFinal", periodo.getDataFinal());

		return query.getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Despesa> getDespesasPorPeriodo(Periodo periodo) {

		StringBuilder builder = new StringBuilder();

		builder.append("SELECT d FROM Despesa d WHERE d.vencimento BETWEEN :dataInicial AND :dataFinal ");

		Query query = entityManager.createQuery(builder.toString());

		query.setParameter("dataInicial", periodo.getDataInicial());
		query.setParameter("dataFinal", periodo.getDataFinal());

		return query.getResultList();
	}

	@Override
	protected Class<Despesa> getClasseEntidade() {
		return Despesa.class;
	}

	@Override
	public void inserir(Despesa despesa) {
		if (despesa.hasParcelamento()) {

			Parcelamento parcelamento = Parcelamento.create(despesa.getParcelamento(), new BigDecimal(despesa.getNumeroParcelas()), despesa);

			salvar(parcelamento.parcelar());

		} else {
			super.inserir(despesa);

			if (despesa.isPaga()) {
				pagar(despesa);
			}
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Despesa> buscarPorFiltro(DespesaFiltro filtro) {

		StringBuilder builder = new StringBuilder();

		builder.append("SELECT d FROM Despesa d WHERE 1 = 1");

		if (filtro.hasDataInicialAndDataFinal()) {
			builder.append(" AND d.vencimento BETWEEN :dataInicial AND :dataFinal ");
		} else if (filtro.hasDataInicial()) {
			builder.append(" AND d.vencimento >= :dataInicial");
		} else if (filtro.hasDataFinal()) {
			builder.append(" AND d.vencimento <= :dataFinal");
		}

		builder.append(" ORDER BY d.vencimento");

		Query query = entityManager.createQuery(builder.toString());

		if (filtro.hasDataInicial()) {
			query.setParameter("dataInicial", DataUtil.truncate(filtro.getDataInicial(), Calendar.DAY_OF_MONTH));
		}

		if (filtro.hasDataFinal()) {
			query.setParameter("dataFinal", DataUtil.maximo(filtro.getDataFinal(), Calendar.DAY_OF_MONTH));
		}

		return query.getResultList();
	}

	@Override
	public void pagar(Despesa despesa) {
		despesa.pagar();

		salvar(despesa);
		//contaFacade.salvar(despesa.getDebitavel());
	}

}