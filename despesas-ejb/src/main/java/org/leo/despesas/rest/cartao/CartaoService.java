package org.leo.despesas.rest.cartao;

import javax.ejb.EJB;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.cartao.CartaoFacade;
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.infra.AbstractService;

@Path("/cartao")
public class CartaoService extends AbstractService<CartaoFacade, CartaoCredito> {

	@EJB
	private CartaoFacade cartaoFacade;

	@Override
	protected CartaoFacade getFacade() {
		return this.cartaoFacade;
	}

}
