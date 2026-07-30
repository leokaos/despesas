package org.leo.despesas.rest.alerta;

import javax.ejb.EJB;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.leo.despesas.aplicacao.alerta.AlertaFacade;
import org.leo.despesas.aplicacao.alerta.AlertaJob;
import org.leo.despesas.dominio.alerta.Alerta;
import org.leo.despesas.dominio.alerta.AlertaFiltro;
import org.leo.despesas.infra.AbstractService;
import org.leo.despesas.infra.exception.DespesasException;

@Path("/alerta")
public class AlertaService extends AbstractService<AlertaFacade, Alerta, AlertaFiltro> {

	@EJB
	private AlertaFacade alertaFacade;

	@EJB
	private AlertaJob alertaJob;

	@Override
	protected AlertaFacade getFacade() {
		return this.alertaFacade;
	}

	@GET
	@Path("/run")
	@Produces(value = MediaType.APPLICATION_JSON)
	public Response aaaaaa() throws DespesasException {
		alertaJob.executar();
		return Response.ok().build();
	}

}
