package org.leo.despesas.aplicacao.transferencia;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.Query;

import org.leo.despesas.aplicacao.conta.ContaFacade;
import org.leo.despesas.aplicacao.fatura.FaturaFacade;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.dominio.movimentacao.TransferenciaFiltro;
import org.leo.despesas.infra.DataUtil;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.rest.infra.AbstractFacade;

@Stateless
public class TransferenciaFacadeImpl extends AbstractFacade<Transferencia> implements TransferenciaFacade {

	@EJB
	private ContaFacade contaFacade;

	@EJB
	private FaturaFacade faturaFacade;

	@Override
	public void pagarFatura(final Fatura fatura, final Conta conta, Date dataPagamento) throws DespesasException {
		final Transferencia transferencia = fatura.pagar(conta);
		
		transferencia.setPagamento(dataPagamento);

		inserir(transferencia);

		faturaFacade.salvar(fatura);
		contaFacade.salvar(conta);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Transferencia> getTransferenciasPorPeriodo(final Periodo periodo) {

		final StringBuilder builder = new StringBuilder();

		builder.append("SELECT t FROM Transferencia t WHERE t.vencimento BETWEEN :dataInicial AND :dataFinal ");

		final Query query = entityManager.createQuery(builder.toString());

		query.setParameter("dataInicial", periodo.getDataInicial());
		query.setParameter("dataFinal", periodo.getDataFinal());

		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Transferencia> buscarPorFiltro(final TransferenciaFiltro filtro) {

		final StringBuilder builder = new StringBuilder();

		builder.append("SELECT t FROM Transferencia t WHERE 1 = 1");

		if (filtro.hasDataInicialAndDataFinal()) {
			builder.append(" AND t.vencimento BETWEEN :dataInicial AND :dataFinal ");
		} else if (filtro.hasDataInicial()) {
			builder.append(" AND t.vencimento >= :dataInicial");
		} else if (filtro.hasDataFinal()) {
			builder.append(" AND t.vencimento <= :dataFinal");
		}

		builder.append(" ORDER BY t.vencimento");

		final Query query = entityManager.createQuery(builder.toString());

		if (filtro.hasDataInicial()) {
			query.setParameter("dataInicial", DataUtil.truncate(filtro.getDataInicial(), Calendar.DAY_OF_MONTH));
		}

		if (filtro.hasDataFinal()) {
			query.setParameter("dataFinal", DataUtil.maximo(filtro.getDataFinal(), Calendar.DAY_OF_MONTH));
		}

		return query.getResultList();
	}

	@Override
	protected Class<Transferencia> getClasseEntidade() {
		return Transferencia.class;
	}

}
