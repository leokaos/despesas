package org.leo.despesas.rest.infra;

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

import org.jboss.resteasy.annotations.Form;
import org.leo.despesas.infra.exception.DespesasException;

public abstract class AbstractService<T extends SimpleFacade<E, F>, E extends ModelEntity, F extends ModelFiltro<E>> implements SimpleService<E, F> {

	@GET
	@Override
	@Produces(value = MediaType.APPLICATION_JSON)
	public List<E> listar(@Form F filtro) {
		return getFacade().listar(filtro);
	}

	@GET
	@Override
	@Path("/{id}")
	@Produces(value = MediaType.APPLICATION_JSON)
	public Response buscarPorId(@PathParam(value = "id") final Long id) throws DespesasException {
		return Response.ok(getFacade().buscarPorId(id)).build();
	}

	@POST
	@Override
	@Consumes(value = MediaType.APPLICATION_JSON)
	public Response inserir(final E t) throws DespesasException {
		getFacade().inserir(t);

		return Response.created(null).build();
	}

	@PUT
	@Override
	@Consumes(value = MediaType.APPLICATION_JSON)
	public Response salvar(final E t) {
		getFacade().salvar(t);

		return Response.ok().build();
	}

	@DELETE
	@Override
	@Path("/{id}")
	public Response deletar(@PathParam(value = "id") final Long id) throws DespesasException {
		getFacade().deletar(id);

		return Response.ok().build();
	}

	protected abstract T getFacade();

}
