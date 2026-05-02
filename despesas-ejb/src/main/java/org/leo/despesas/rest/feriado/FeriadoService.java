package org.leo.despesas.rest.feriado;

import java.util.List;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.leo.despesas.aplicacao.feriado.FeriadoFacade;
import org.leo.despesas.dominio.feriado.Feriado;
import org.leo.despesas.dominio.feriado.FeriadoFiltro;
import org.leo.despesas.dominio.feriado.FeriadoTipo;
import org.leo.despesas.infra.AbstractService;
import org.leo.despesas.infra.exception.DespesasException;

@Path("/feriado")
@RequestScoped
public class FeriadoService extends AbstractService<FeriadoFacade, Feriado, FeriadoFiltro> {

	@EJB
	private FeriadoFacade feriadoFacade;

	@GET
	@Path("/externo")
	@Produces(value = MediaType.APPLICATION_JSON)
	public List<Feriado> getFeriadosPelaApi(@QueryParam(value = "ano") Integer ano, @QueryParam(value = "tipo") FeriadoTipo tipo) throws DespesasException {
		return this.feriadoFacade.getFeriadosPelaApi(ano, tipo);
	}

	@Override
	protected FeriadoFacade getFacade() {
		return this.feriadoFacade;
	}

}
