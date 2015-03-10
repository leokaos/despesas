package org.leo.despesas.infra;

import java.util.List;

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

public abstract class AbstractService<T extends SimpleFacade<E>, E> implements SimpleService<E> {

	@GET
	@Override
	@Produces(value = MediaType.APPLICATION_JSON)
	public List<E> listar() {
		return getFacade().listar();
	}

	@GET
	@Override
	@Path("/{id}")
	@Produces(value = MediaType.APPLICATION_JSON)
	public E buscarPorId(@PathParam(value = "id") Long id) {
		return getFacade().buscarPorId(id);
	}

	@POST
	@Override
	@Consumes(value = MediaType.APPLICATION_JSON)
	public Response inserir(E t) {
		getFacade().inserir(t);

		return Response.status(200).build();
	}

	@PUT
	@Override
	@Consumes(value = MediaType.APPLICATION_JSON)
	public Response salvar(E t) {
		getFacade().salvar(t);

		return Response.status(200).build();
	}

	@DELETE
	@Override
	@Path("/{id}")
	public Response deletar(@PathParam(value = "id") Long id) {
		getFacade().deletar(id);

		return Response.status(200).build();
	}

	protected abstract T getFacade();

}
