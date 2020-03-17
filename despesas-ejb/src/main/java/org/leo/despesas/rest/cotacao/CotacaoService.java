package org.leo.despesas.rest.cotacao;

import javax.ejb.EJB;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.leo.despesas.aplicacao.cotacao.CotacaoFacade;
import org.leo.despesas.dominio.servicotransferencia.Cotacao;
import org.leo.despesas.dominio.servicotransferencia.CotacaoFiltro;
import org.leo.despesas.infra.AbstractService;
import org.leo.despesas.infra.Moeda;

@Path("/cotacao")
public class CotacaoService extends AbstractService<CotacaoFacade, Cotacao,CotacaoFiltro> {

	@EJB
	private CotacaoFacade cotacaoFacade;

	@POST
	@Path("/nova")
	@Produces(value = MediaType.APPLICATION_JSON)
	public Cotacao getCotacaoDaInternet(@QueryParam(value = "origem") Moeda origem, @QueryParam(value = "destino") Moeda destino) {
		return this.cotacaoFacade.buscarCotacaoInternet(origem, destino);
	}

	@Override
	protected CotacaoFacade getFacade() {
		return this.cotacaoFacade;
	}

}