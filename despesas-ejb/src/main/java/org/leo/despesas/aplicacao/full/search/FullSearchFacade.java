package org.leo.despesas.aplicacao.full.search;

import javax.ejb.Local;

import org.leo.despesas.infra.exception.DespesasException;

@Local
public interface FullSearchFacade {
	
	void initIndex() throws DespesasException;

}
