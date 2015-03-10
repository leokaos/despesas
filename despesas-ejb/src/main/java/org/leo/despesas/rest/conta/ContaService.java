package org.leo.despesas.rest.conta;

import javax.ejb.EJB;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.conta.ContaFacade;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.infra.AbstractService;

@Path("/conta")
public class ContaService extends AbstractService<ContaFacade, Conta> {

	@EJB
	private ContaFacade contaFacade;

	@Override
	protected ContaFacade getFacade() {
		return this.contaFacade;
	}

}
