package org.leo.despesas.aplicacao.movimentacao;

import java.util.Date;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.leo.despesas.dominio.movimentacao.Movimentacao;
import org.leo.despesas.infra.Moeda;

@Stateless
public class MovimentacaoFacadeImpl implements MovimentacaoFacade {

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	@Override
	@SuppressWarnings("unchecked")
	public List<Movimentacao> buscarMovimentacaoPorPeriodo(Date dataInicial, Date dataFinal) {

		Query query = entityManager.createQuery("SELECT M FROM Movimentacao M WHERE M.vencimento BETWEEN :dataInicial AND :dataFinal AND M.moeda = :moeda");

		query.setParameter("dataInicial", dataInicial);
		query.setParameter("dataFinal", dataFinal);

		query.setParameter("moeda", Moeda.EURO);

		return query.getResultList();
	}

}
