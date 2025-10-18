package org.leo.despesas.rest.divida;

import javax.ejb.EJB;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.leo.despesas.aplicacao.divida.DividaFacade;
import org.leo.despesas.dominio.debitavel.Divida;
import org.leo.despesas.dominio.debitavel.DividaFiltro;
import org.leo.despesas.infra.AbstractService;
import org.leo.despesas.infra.exception.DespesasException;

@Path(value = "/divida")
public class DividaService extends AbstractService<DividaFacade, Divida, DividaFiltro> {

	@EJB
	private DividaFacade dividaFacade;

	@Override
	protected DividaFacade getFacade() {
		return dividaFacade;
	}

	@GET
	@Path("/{id}/pagamentos")
	@Produces(value = MediaType.APPLICATION_JSON)
	public Response getPagamentos(@PathParam(value = "id") final Long id) throws DespesasException {
		return Response.ok(dividaFacade.getPagamentos(id)).build();
	}

}
