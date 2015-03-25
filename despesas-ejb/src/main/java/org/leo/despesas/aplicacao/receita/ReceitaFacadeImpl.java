package org.leo.despesas.aplicacao.receita;

import java.util.Calendar;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.Query;

import org.leo.despesas.aplicacao.debitavel.DebitavelFacade;
import org.leo.despesas.dominio.movimentacao.GraficoVO;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.ReceitaFiltro;
import org.leo.despesas.infra.DataUtil;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.rest.infra.AbstractFacade;

@Stateless
public class ReceitaFacadeImpl extends AbstractFacade<Receita> implements ReceitaFacade {

	@EJB
	private DebitavelFacade debitavelFacade;

	@Override
	@SuppressWarnings("unchecked")
	public List<GraficoVO> getGraficoPorPeriodo(Periodo periodo) {
		StringBuilder builder = new StringBuilder();

		builder.append("SELECT NEW org.leo.despesas.dominio.movimentacao.GraficoVO(r.tipoReceita.descricao,r.tipoReceita.cor, SUM(r.valor)) FROM Receita r ");
		builder.append("WHERE r.vencimento BETWEEN :dataInicial AND :dataFinal ");
		builder.append("GROUP BY r.tipoReceita.descricao, r.tipoReceita.cor");

		Query query = entityManager.createQuery(builder.toString());

		query.setParameter("dataInicial", periodo.getDataInicial());
		query.setParameter("dataFinal", periodo.getDataFinal());

		return query.getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Receita> getReceitasPorPeriodo(Periodo periodo) {

		StringBuilder builder = new StringBuilder();

		builder.append("SELECT r FROM Receita r WHERE r.vencimento BETWEEN :dataInicial AND :dataFinal ");

		Query query = entityManager.createQuery(builder.toString());

		query.setParameter("dataInicial", periodo.getDataInicial());
		query.setParameter("dataFinal", periodo.getDataFinal());

		return query.getResultList();
	}

	@Override
	protected Class<Receita> getClasseEntidade() {
		return Receita.class;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Receita> buscarPorFiltro(ReceitaFiltro filtro) {

		StringBuilder builder = new StringBuilder();

		builder.append("SELECT r FROM Receita r WHERE 1 = 1");

		if (filtro.hasDataInicialAndDataFinal()) {
			builder.append(" AND r.vencimento BETWEEN :dataInicial AND :dataFinal ");
		} else if (filtro.hasDataInicial()) {
			builder.append(" AND r.vencimento >= :dataInicial");
		} else if (filtro.hasDataFinal()) {
			builder.append(" AND r.vencimento <= :dataFinal");
		}

		if (filtro.hasTipoReceita()) {
			builder.append(" AND r.tipoReceita.id = :tipoReceitaId");
		}

		builder.append(" ORDER BY r.vencimento");

		Query query = entityManager.createQuery(builder.toString());

		if (filtro.hasDataInicial()) {
			query.setParameter("dataInicial", DataUtil.truncate(filtro.getDataInicial(), Calendar.DAY_OF_MONTH));
		}

		if (filtro.hasDataFinal()) {
			query.setParameter("dataFinal", DataUtil.maximo(filtro.getDataFinal(), Calendar.DAY_OF_MONTH));
		}

		if (filtro.hasTipoReceita()) {
			query.setParameter("tipoReceitaId", filtro.getTipoReceita().getId());
		}

		return query.getResultList();
	}

	@Override
	public void inserir(Receita receita) {
		super.inserir(receita);

		if (receita.isDepositado()) {
			depositar(receita);
		}
	}

	@Override
	public void depositar(Receita receita) {

		receita.setDebitavel(debitavelFacade.buscarPorId(receita.getDebitavel().getId()));

		receita.depositar();

		salvar(receita);
		debitavelFacade.salvar(receita.getDebitavel());
	}

}