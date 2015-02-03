package org.leo.despesas.rest;

import java.util.Date;
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
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.leo.despesas.dominio.Despesa;
import org.leo.despesas.dominio.GraficoVO;
import org.leo.despesas.dominio.Periodo;
import org.leo.despesas.dominio.despesa.DespesaFacade;
import org.leo.despesas.rest.infra.SimpleService;

@Path("/despesa")
@RequestScoped
public class DespesaService implements SimpleService<Despesa> {

	@EJB
	private DespesaFacade despesaFacade;

	@GET
	@Override
	@Produces(value = MediaType.APPLICATION_JSON)
	public List<Despesa> listar() {
		return despesaFacade.listar();
	}

	@GET
	@Override
	@Path("/{id}")
	@Produces(value = MediaType.APPLICATION_JSON)
	public Despesa buscarPorId(@PathParam(value = "id") Long id) {
		return despesaFacade.buscarPorId(id);
	}

	@POST
	@Override
	@Consumes(value = MediaType.APPLICATION_JSON)
	public Response inserir(Despesa t) {

		despesaFacade.inserir(t);

		return Response.status(200).build();
	}

	@PUT
	@Override
	@Consumes(value = MediaType.APPLICATION_JSON)
	public Response salvar(Despesa t) {
		despesaFacade.salvar(t);

		return Response.status(200).build();
	}

	@DELETE
	@Override
	@Path("/{id}")
	public Response deletar(@PathParam(value = "id") Long id) {
		despesaFacade.deletar(id);

		return Response.status(200).build();
	}

	@GET
	@Path(value = "/grafico")
	@Produces(MediaType.APPLICATION_JSON)
	public List<GraficoVO> buscarPorPeriodo(@QueryParam("dataInicial") Date dataInicial, @QueryParam("dataFinal") Date dataFinal) {
		return despesaFacade.getGraficoPorPeriodo(new Periodo(dataInicial, dataFinal));
	}

	@GET
	@Path(value = "/periodo")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Despesa> buscarPorDespesasPorPeriodo(@QueryParam("dataInicial") Date dataInicial, @QueryParam("dataFinal") Date dataFinal) {
		return despesaFacade.getDespesasPorPeriodo(new Periodo(dataInicial, dataFinal));
	}

}
