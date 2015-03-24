package org.leo.despesas.rest.receita;

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

import org.leo.despesas.aplicacao.receita.ReceitaFacade;
import org.leo.despesas.dominio.movimentacao.GraficoVO;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.ReceitaFiltro;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.rest.infra.AbstractService;

@Path("/receita")
@RequestScoped
public class ReceitaService extends AbstractService<ReceitaFacade, Receita> {

    @EJB
    private ReceitaFacade receitaFacade;

    @GET
    @Path(value = "/grafico")
    @Produces(MediaType.APPLICATION_JSON)
    public List<GraficoVO> buscarPorPeriodo(@QueryParam("dataInicial") Date dataInicial, @QueryParam("dataFinal") Date dataFinal) {
	return receitaFacade.getGraficoPorPeriodo(new Periodo(dataInicial, dataFinal));
    }

    @GET
    @Path(value = "/periodo")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Receita> buscarPorDespesasPorPeriodo(@QueryParam("dataInicial") Date dataInicial, @QueryParam("dataFinal") Date dataFinal) {
	return receitaFacade.getReceitasPorPeriodo(new Periodo(dataInicial, dataFinal));
    }

    @POST
    @Path(value = "/filtro")
    @Consumes(MediaType.APPLICATION_JSON)
    public List<Receita> buscarPorFiltro(ReceitaFiltro filtro) {
	return getFacade().buscarPorFiltro(filtro);
    }

    @POST
    @Path(value = "/depositar")
    public void depositar(Long id) {
	receitaFacade.depositar(receitaFacade.buscarPorId(id));
    }

    @Override
    protected ReceitaFacade getFacade() {
	return this.receitaFacade;
    }

}
