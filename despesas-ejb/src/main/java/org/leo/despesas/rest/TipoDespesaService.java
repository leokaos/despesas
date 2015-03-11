package org.leo.despesas.rest;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.tipodespesa.TipoDespesaFacade;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;
import org.leo.despesas.rest.infra.AbstractService;

@Path("/tipodespesa")
@RequestScoped
public class TipoDespesaService extends AbstractService<TipoDespesaFacade, TipoDespesa> {

	@EJB
	private TipoDespesaFacade tipoDespesaFacade;

	@Override
	protected TipoDespesaFacade getFacade() {
		return this.tipoDespesaFacade;
	}

}
