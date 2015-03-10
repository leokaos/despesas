package org.leo.despesas.rest.despesa;

import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.leo.despesas.aplicacao.despesa.DespesaFacade;
import org.leo.despesas.dominio.GraficoVO;
import org.leo.despesas.dominio.debitavel.DespesaFiltro;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.infra.AbstractService;
import org.leo.despesas.infra.Periodo;

@Path("/despesa")
@RequestScoped
public class DespesaService extends AbstractService<DespesaFacade, Despesa> {

	@EJB
	private DespesaFacade despesaFacade;

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

	@POST
	@Path(value = "/filtro")
	@Consumes(MediaType.APPLICATION_JSON)
	public List<Despesa> buscarPorFiltro(DespesaFiltro filtro) {
		return getFacade().buscarPorFiltro(filtro);
	}

	@POST
	@Path(value = "/pagar")
	public void pagar(Long id) {
		despesaFacade.pagar(despesaFacade.buscarPorId(id));
	}

	@Override
	protected DespesaFacade getFacade() {
		return this.despesaFacade;
	}

}
