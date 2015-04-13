package org.leo.despesas.rest.dashboard;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.leo.despesas.aplicacao.dashboard.DashboardFacade;
import org.leo.despesas.aplicacao.despesa.DespesaFacade;
import org.leo.despesas.aplicacao.receita.ReceitaFacade;
import org.leo.despesas.dominio.movimentacao.TipoGrafico;
import org.leo.despesas.dominio.movimentacao.WrapperGraficoVO;
import org.leo.despesas.infra.Periodo;

@Path("/dashbboard")
@RequestScoped
public class DashboardService {

	@EJB
	private DespesaFacade despesaFacade;

	@EJB
	private ReceitaFacade receitaFacade;

	@EJB
	private DashboardFacade dashboardFacade;

	@GET
	@Path(value = "/main")
	@Produces(MediaType.APPLICATION_JSON)
	public List<WrapperGraficoVO> buscarPorPeriodo(@QueryParam("dataInicial") Date dataInicial, @QueryParam("dataFinal") Date dataFinal) {

		List<WrapperGraficoVO> wrappers = new ArrayList<WrapperGraficoVO>();
		Periodo periodo = new Periodo(dataInicial, dataFinal);

		// DESPESAS POR TIPO
		wrappers.add(new WrapperGraficoVO("Despesas Por Tipo", TipoGrafico.PIZZA, despesaFacade.getGraficoPorPeriodo(periodo)));

		// RECEITAS POR TIPO
		wrappers.add(new WrapperGraficoVO("Receitas Por Tipo", TipoGrafico.PIZZA, receitaFacade.getGraficoPorPeriodo(periodo)));

		// EXTRATO
		wrappers.add(new WrapperGraficoVO("Extrato Mensal", TipoGrafico.BARRAS, dashboardFacade.getExtratoMes(dataInicial, dataFinal)));

		return wrappers;
	}
}
