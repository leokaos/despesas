package org.leo.despesas.rest.movimentacao;

import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.leo.despesas.aplicacao.movimentacao.MovimentacaoFacade;
import org.leo.despesas.dominio.movimentacao.Movimentacao;

@Path("/movimentacao")
@RequestScoped
public class MovimentacaoService {

	@EJB
	private MovimentacaoFacade movimentacaoFacade;

	@GET
	@Path(value = "/buscarPorPeriodo")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Movimentacao> buscarPorPeriodo(@QueryParam("dataInicial") final Date dataInicial,@QueryParam("dataFinal") final Date dataFinal) {
		return movimentacaoFacade.buscarMovimentacaoPorPeriodo(dataInicial,dataFinal);
	}

}
