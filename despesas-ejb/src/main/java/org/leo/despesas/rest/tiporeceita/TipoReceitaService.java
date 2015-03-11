package org.leo.despesas.rest.tiporeceita;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.tiporeceita.TipoReceitaFacade;
import org.leo.despesas.dominio.tipomovimentacao.TipoReceita;
import org.leo.despesas.rest.infra.AbstractService;

@Path("/tiporeceita")
@RequestScoped
public class TipoReceitaService extends AbstractService<TipoReceitaFacade, TipoReceita> {

	@EJB
	private TipoReceitaFacade tipoReceitaFacade;

	@Override
	protected TipoReceitaFacade getFacade() {
		return this.tipoReceitaFacade;
	}

}
