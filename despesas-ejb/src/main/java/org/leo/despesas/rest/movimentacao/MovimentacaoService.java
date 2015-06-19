package org.leo.despesas.rest.movimentacao;

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

import org.leo.despesas.aplicacao.despesa.DespesaFacade;
import org.leo.despesas.aplicacao.receita.ReceitaFacade;
import org.leo.despesas.dominio.debitavel.DespesaFiltro;
import org.leo.despesas.dominio.movimentacao.Movimentacao;
import org.leo.despesas.dominio.movimentacao.ReceitaFiltro;

@Path("/movimentacao")
@RequestScoped
public class MovimentacaoService {

	@EJB
	private DespesaFacade despesaFacade;

	@EJB
	private ReceitaFacade receitaFacade;

	@GET
	@Path(value = "/main")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Movimentacao> buscarPorPeriodo(@QueryParam("dataInicial") final Date dataInicial, @QueryParam("dataFinal") final Date dataFinal) {
		final List<Movimentacao> movimentacoes = new ArrayList<>();

		final DespesaFiltro despesaFiltro = new DespesaFiltro();
		despesaFiltro.setDataInicial(dataInicial);
		despesaFiltro.setDataFinal(dataFinal);

		movimentacoes.addAll(despesaFacade.buscarPorFiltro(despesaFiltro));

		final ReceitaFiltro receitaFiltro = new ReceitaFiltro();
		receitaFiltro.setDataInicial(dataInicial);
		receitaFiltro.setDataFinal(dataFinal);

		movimentacoes.addAll(receitaFacade.buscarPorFiltro(receitaFiltro));

		return movimentacoes;
	}

}
