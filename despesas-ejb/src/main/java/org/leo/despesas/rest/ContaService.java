package org.leo.despesas.rest;

import java.util.List;

import javax.ejb.EJB;
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

import org.leo.despesas.dominio.Conta;
import org.leo.despesas.dominio.conta.ContaFacade;
import org.leo.despesas.rest.infra.SimpleService;

@Path("/conta")
public class ContaService implements SimpleService<Conta> {

	@EJB
	private ContaFacade contaFacade;

	@GET
	@Override
	@Produces(value = MediaType.APPLICATION_JSON)
	public List<Conta> listar() {
		return contaFacade.listar();
	}

	@GET
	@Override
	@Path("/{id}")
	@Produces(value = MediaType.APPLICATION_JSON)
	public Conta buscarPorId(@PathParam(value = "id") Long id) {
		return contaFacade.buscarPorId(id);
	}

	@POST
	@Override
	@Consumes(value = MediaType.APPLICATION_JSON)
	public Response inserir(Conta t) {

		contaFacade.inserir(t);

		return Response.status(200).build();
	}

	@PUT
	@Override
	@Consumes(value = MediaType.APPLICATION_JSON)
	public Response salvar(Conta t) {
		contaFacade.salvar(t);

		return Response.status(200).build();
	}

	@DELETE
	@Override
	@Path("/{id}")
	public Response deletar(@PathParam(value = "id") Long id) {
		contaFacade.deletar(id);

		return Response.status(200).build();
	}

}
