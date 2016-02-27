package org.leo.despesas.aplicacao.movimentacao;

import java.util.Date;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.leo.despesas.dominio.movimentacao.Movimentacao;

@Stateless
public class MovimentacaoFacadeImpl implements MovimentacaoFacade {

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	@Override
	@SuppressWarnings("unchecked")
	public List<Movimentacao> buscarMovimentacaoPorPeriodo(Date dataInicial,Date dataFinal) {
		Query query = entityManager.createQuery("SELECT M FROM Movimentacao M WHERE M.vencimento BETWEEN :dataInicial AND :dataFinal");

		query.setParameter("dataInicial",dataInicial);
		query.setParameter("dataFinal",dataFinal);

		return query.getResultList();
	}

}
