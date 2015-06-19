package org.leo.despesas.aplicacao.despesa;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.Query;

import org.leo.despesas.aplicacao.debitavel.DebitavelFacade;
import org.leo.despesas.dominio.debitavel.DespesaFiltro;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.GraficoVO;
import org.leo.despesas.dominio.parcelamento.Parcelamento;
import org.leo.despesas.infra.DataUtil;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.rest.infra.AbstractFacade;

@Stateless
public class DespesaFacadeImpl extends AbstractFacade<Despesa> implements DespesaFacade {

	@EJB
	private DebitavelFacade debitavelFacade;

	@Override
	@SuppressWarnings("unchecked")
	public List<GraficoVO> getGraficoPorPeriodo(final Periodo periodo) {
		final StringBuilder builder = new StringBuilder();

		builder.append("SELECT NEW org.leo.despesas.dominio.movimentacao.GraficoVO(d.tipo.descricao,d.tipo.cor, SUM(d.valor)) FROM Despesa d ");
		builder.append("WHERE d.vencimento BETWEEN :dataInicial AND :dataFinal ");
		builder.append("GROUP BY d.tipo.descricao, d.tipo.cor");

		final Query query = entityManager.createQuery(builder.toString());

		query.setParameter("dataInicial", periodo.getDataInicial());
		query.setParameter("dataFinal", periodo.getDataFinal());

		return query.getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Despesa> getDespesasPorPeriodo(final Periodo periodo) {

		final StringBuilder builder = new StringBuilder();

		builder.append("SELECT d FROM Despesa d WHERE d.vencimento BETWEEN :dataInicial AND :dataFinal ");

		final Query query = entityManager.createQuery(builder.toString());

		query.setParameter("dataInicial", periodo.getDataInicial());
		query.setParameter("dataFinal", periodo.getDataFinal());

		return query.getResultList();
	}

	@Override
	protected Class<Despesa> getClasseEntidade() {
		return Despesa.class;
	}

	@Override
	public void inserir(final Despesa despesa) {
		if (despesa.hasParcelamento()) {

			final Parcelamento parcelamento = Parcelamento.create(despesa.getParcelamento(), new BigDecimal(despesa.getNumeroParcelas()), despesa);

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
	public List<Despesa> buscarPorFiltro(final DespesaFiltro filtro) {

		final StringBuilder builder = new StringBuilder();

		builder.append("SELECT d FROM Despesa d WHERE 1 = 1");

		if (filtro.hasDataInicialAndDataFinal()) {
			builder.append(" AND d.vencimento BETWEEN :dataInicial AND :dataFinal ");
		} else if (filtro.hasDataInicial()) {
			builder.append(" AND d.vencimento >= :dataInicial");
		} else if (filtro.hasDataFinal()) {
			builder.append(" AND d.vencimento <= :dataFinal");
		}

		if (filtro.hasTipoDespesa()) {
			builder.append(" AND d.tipo.id = :tipoDespesaId");
		}

		builder.append(" ORDER BY d.vencimento");

		final Query query = entityManager.createQuery(builder.toString());

		if (filtro.hasDataInicial()) {
			query.setParameter("dataInicial", DataUtil.truncate(filtro.getDataInicial(), Calendar.DAY_OF_MONTH));
		}

		if (filtro.hasDataFinal()) {
			query.setParameter("dataFinal", DataUtil.maximo(filtro.getDataFinal(), Calendar.DAY_OF_MONTH));
		}

		if (filtro.hasTipoDespesa()) {
			query.setParameter("tipoDespesaId", filtro.getTipoDespesa().getId());
		}

		return query.getResultList();
	}

	@Override
	public void pagar(final Despesa despesa) {

		despesa.setDebitavel(debitavelFacade.buscarPorId(despesa.getDebitavel().getId()));

		despesa.pagar();

		debitavelFacade.salvar(despesa.getDebitavel());
		salvar(despesa.consolidar());
	}
}