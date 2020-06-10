package org.leo.despesas.aplicacao.divida;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.debitavel.Divida;
import org.leo.despesas.dominio.debitavel.DividaFiltro;
import org.leo.despesas.infra.AbstractFacade;

@Stateless
public class DividaFacadeImpl extends AbstractFacade<Divida, DividaFiltro> implements DividaFacade {

	@Override
	protected Class<Divida> getClasseEntidade() {
		return Divida.class;
	}

}
