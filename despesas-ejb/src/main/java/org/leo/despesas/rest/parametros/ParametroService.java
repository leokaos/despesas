package org.leo.despesas.rest.parametros;

import javax.ejb.EJB;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.leo.despesas.aplicacao.parametro.ParametroFacade;

@Path("/parametro")
public class ParametroService {

	@EJB
	private ParametroFacade parametroFacade;

	@GET
	@Produces(value = MediaType.APPLICATION_JSON)
	public String getParametro(@QueryParam("nome") String nome) {
		return parametroFacade.buscarParametroPorId(nome);
	}
}
