package org.leo.despesas.aplicacao.cartao;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.rest.infra.AbstractFacade;

@Stateless
public class CartaoFacadeImpl extends AbstractFacade<CartaoCredito> implements CartaoFacade {

	@Override
	protected Class<CartaoCredito> getClasseEntidade() {
		return CartaoCredito.class;
	}

}