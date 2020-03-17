package org.leo.despesas.rest.tiporeceita;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.tiporeceita.TipoReceitaFacade;
import org.leo.despesas.dominio.tipomovimentacao.TipoReceita;
import org.leo.despesas.dominio.tipomovimentacao.TipoReceitaFiltro;
import org.leo.despesas.infra.AbstractService;

@Path("/tiporeceita")
@RequestScoped
public class TipoReceitaService extends AbstractService<TipoReceitaFacade, TipoReceita, TipoReceitaFiltro> {

	@EJB
	private TipoReceitaFacade tipoReceitaFacade;

	@Override
	protected TipoReceitaFacade getFacade() {
		return this.tipoReceitaFacade;
	}

}
