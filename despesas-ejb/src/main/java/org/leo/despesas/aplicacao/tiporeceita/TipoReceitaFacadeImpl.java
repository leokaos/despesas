package org.leo.despesas.aplicacao.tiporeceita;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.tipomovimentacao.TipoReceita;
import org.leo.despesas.rest.infra.AbstractFacade;

@Stateless
public class TipoReceitaFacadeImpl extends AbstractFacade<TipoReceita> implements TipoReceitaFacade {

	@Override
	protected Class<TipoReceita> getClasseEntidade() {
		return TipoReceita.class;
	}

}