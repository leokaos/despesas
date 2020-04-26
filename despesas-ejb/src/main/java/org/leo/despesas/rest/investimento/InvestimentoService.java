package org.leo.despesas.rest.investimento;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.investimento.InvestimentoFacade;
import org.leo.despesas.dominio.debitavel.Investimento;
import org.leo.despesas.dominio.debitavel.InvestimentoFiltro;
import org.leo.despesas.infra.AbstractService;

@Path("/investimento")
@RequestScoped
public class InvestimentoService extends AbstractService<InvestimentoFacade, Investimento, InvestimentoFiltro> {

	@EJB
	private InvestimentoFacade investimentoFacade;

	@Override
	protected InvestimentoFacade getFacade() {
		return this.investimentoFacade;
	}

}
