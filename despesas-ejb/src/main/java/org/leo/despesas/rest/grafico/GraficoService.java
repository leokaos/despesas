package org.leo.despesas.rest.grafico;

import java.util.Date;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.leo.despesas.aplicacao.grafico.GraficoFacade;
import org.leo.despesas.infra.grafico.GraficoLinha;

@Path("/grafico")
@RequestScoped
public class GraficoService {

	@EJB
	private GraficoFacade graficoFacade;

	@GET
	@Path(value = "/despesas")
	@Produces(MediaType.APPLICATION_JSON)
	public GraficoLinha getGraficoDespesas(@QueryParam("dataInicial") final Date dataInicial,@QueryParam("dataFinal") final Date dataFinal) {
		return graficoFacade.getGraficoDespesas(dataInicial,dataFinal);
	}

}
