package org.leo.despesas.rest;

import java.util.List;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.leo.despesas.dominio.TipoDespesa;
import org.leo.despesas.dominio.tipodespesa.TipoDespesaFacade;
import org.leo.despesas.rest.infra.SimpleService;

@Path("/tipodespesa")
@RequestScoped
public class TipoDespesaService implements SimpleService<TipoDespesa> {

	@EJB
	private TipoDespesaFacade tipoDespesaFacade;

	@GET
	@Override
	@Produces(value = MediaType.APPLICATION_JSON)
	public List<TipoDespesa> listar() {
		return tipoDespesaFacade.listar();
	}

	@GET
	@Override
	@Path("/{id}")
	@Produces(value = MediaType.APPLICATION_JSON)
	public TipoDespesa buscarPorId(@PathParam(value = "id") Long id) {
		return tipoDespesaFacade.buscarPorId(id);
	}

	@POST
	@Override
	@Consumes(value = MediaType.APPLICATION_JSON)
	public Response inserir(TipoDespesa t) {

		tipoDespesaFacade.inserir(t);

		return Response.status(200).build();
	}

	@PUT
	@Override
	@Consumes(value = MediaType.APPLICATION_JSON)
	public Response salvar(TipoDespesa t) {
		tipoDespesaFacade.salvar(t);

		return Response.status(200).build();
	}

	@DELETE
	@Override
	@Path("/{id}")
	public Response deletar(@PathParam(value = "id") Long id) {
		tipoDespesaFacade.deletar(id);

		return Response.status(200).build();
	}

}
