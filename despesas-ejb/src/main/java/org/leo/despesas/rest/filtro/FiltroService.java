package org.leo.despesas.rest.filtro;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.filtro.FiltroFacade;
import org.leo.despesas.dominio.filtro.Filtro;
import org.leo.despesas.dominio.filtro.FiltroModelFiltro;
import org.leo.despesas.infra.AbstractService;

@Path("/filtro")
@RequestScoped
public class FiltroService extends AbstractService<FiltroFacade, Filtro, FiltroModelFiltro> {

	@EJB
	private FiltroFacade facade;

	public FiltroFacade getFacade() {
		return facade;
	}

}
