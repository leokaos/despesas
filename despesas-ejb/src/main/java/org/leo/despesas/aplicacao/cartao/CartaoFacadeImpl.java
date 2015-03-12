package org.leo.despesas.aplicacao.cartao;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.rest.infra.AbstractFacade;

@Stateless
public class CartaoFacadeImpl extends AbstractFacade<CartaoCredito> implements CartaoFacade {

	@PersistenceContext(unitName = "despesasPU")
	private EntityManager entityManager;

	@Override
	protected Class<CartaoCredito> getClasseEntidade() {
		return CartaoCredito.class;
	}

}