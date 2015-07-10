package org.leo.despesas.aplicacao.movimentacao;

import java.util.Date;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.leo.despesas.dominio.movimentacao.Movimentacao;

@Stateless
public class MovimentacaoFacadeImpl implements MovimentacaoFacade {

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	@Override
	@SuppressWarnings("unchecked")
	public List<Movimentacao> buscarMovimentacaoPorPeriodo(Date dataInicial,Date dataFinal) {
		return entityManager.createQuery("SELECT M.* FROM Movimentacao WHERE M.vencimento BETWEEN :dataInicial AND :dataFinal").getResultList();
	}

}
