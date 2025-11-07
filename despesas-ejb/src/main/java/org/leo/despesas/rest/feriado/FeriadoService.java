package org.leo.despesas.rest.feriado;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.feriado.FeriadoFacade;
import org.leo.despesas.dominio.feriado.Feriado;
import org.leo.despesas.dominio.feriado.FeriadoFiltro;
import org.leo.despesas.infra.AbstractService;

@Path("/feriado")
@RequestScoped
public class FeriadoService extends AbstractService<FeriadoFacade, Feriado, FeriadoFiltro> {

	@EJB
	private FeriadoFacade feriadoFacade;

	@Override
	protected FeriadoFacade getFacade() {
		return this.feriadoFacade;
	}

}
