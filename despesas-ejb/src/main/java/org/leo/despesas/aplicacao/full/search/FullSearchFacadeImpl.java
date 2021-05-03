package org.leo.despesas.aplicacao.full.search;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.search.jpa.FullTextEntityManager;
import org.hibernate.search.jpa.Search;
import org.leo.despesas.infra.exception.DespesasException;

@Stateless
public class FullSearchFacadeImpl implements FullSearchFacade {
	
	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	@Override
	public void initIndex() throws DespesasException {
		
		try {

			FullTextEntityManager fullTextSession = Search.getFullTextEntityManager(entityManager);

			fullTextSession.createIndexer().startAndWait();

		} catch (InterruptedException e) {
			throw new DespesasException();
		}
	}

}
