package org.leo.despesas.rest.extrato;

import static javax.ws.rs.core.MediaType.APPLICATION_JSON;

import java.util.Date;
import java.util.List;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import org.leo.despesas.aplicacao.debitavel.DebitavelFacade;
import org.leo.despesas.aplicacao.extrato.ExtratoFacade;
import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.extrato.Extrato;
import org.leo.despesas.infra.exception.DespesasException;

@Path("/extrato")
@RequestScoped
public class ExtratoService {

	@Inject
	private ExtratoFacade extratoFacade;

	@Inject
	private DebitavelFacade debitavelFacade;

	@GET
	@Produces(APPLICATION_JSON)
	public List<Extrato> getProjecao(@QueryParam("dataInicial") Date dataInicio, @QueryParam("dataFinal") Date dataFinal, @QueryParam("id") Long id) throws DespesasException {

		Debitavel debitavel = debitavelFacade.buscarPorId(id);

		return extratoFacade.buscarPorPeriodo(dataInicio, dataFinal, debitavel);
	}
}
