package org.leo.despesas.aplicacao.cartao;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.CartaoCreditoFiltro;
import org.leo.despesas.infra.AbstractFacade;

@Stateless
public class CartaoFacadeImpl extends AbstractFacade<CartaoCredito, CartaoCreditoFiltro> implements CartaoFacade {

	@Override
	protected Class<CartaoCredito> getClasseEntidade() {
		return CartaoCredito.class;
	}

}