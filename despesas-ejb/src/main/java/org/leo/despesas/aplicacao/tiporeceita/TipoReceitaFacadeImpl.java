package org.leo.despesas.aplicacao.tiporeceita;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.tipomovimentacao.TipoReceita;
import org.leo.despesas.dominio.tipomovimentacao.TipoReceitaFiltro;
import org.leo.despesas.infra.AbstractFacade;

@Stateless
public class TipoReceitaFacadeImpl extends AbstractFacade<TipoReceita, TipoReceitaFiltro> implements TipoReceitaFacade {

	@Override
	protected Class<TipoReceita> getClasseEntidade() {
		return TipoReceita.class;
	}

}