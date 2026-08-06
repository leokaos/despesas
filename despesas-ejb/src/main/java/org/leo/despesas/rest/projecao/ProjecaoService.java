package org.leo.despesas.rest.projecao;

import static javax.ws.rs.core.MediaType.APPLICATION_JSON;

import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import org.leo.despesas.aplicacao.debitavel.DebitavelFacade;
import org.leo.despesas.aplicacao.projecao.ProjecaoFacade;
import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.projecao.Projecao;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.exception.DespesasException;

@Path("/projecao")
@RequestScoped
public class ProjecaoService {

	@Inject
	private ProjecaoFacade projecaoFacade;

	@Inject
	private DebitavelFacade debitavelFacade;

	@GET
	@Produces(APPLICATION_JSON)
	public Projecao getProjecao(@QueryParam("debitavelId") Long debitavelId, @QueryParam("meses") int meses) throws DespesasException {

		Debitavel debitavel = debitavelFacade.buscarPorId(debitavelId);

		LocalDate dataInicial = LocalDate.now().with(TemporalAdjusters.firstDayOfNextMonth());
		LocalDate dataFinal = dataInicial.plusMonths(meses);

		return projecaoFacade.criarProjecao(debitavel, new Periodo(dataInicial, dataFinal));
	}
}
