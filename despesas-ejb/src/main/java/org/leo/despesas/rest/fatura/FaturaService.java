package org.leo.despesas.rest.fatura;

import java.util.List;

import javax.ejb.EJB;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.leo.despesas.aplicacao.cartao.CartaoFacade;
import org.leo.despesas.aplicacao.fatura.FaturaFacade;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.rest.infra.AbstractService;

@Path("/fatura")
public class FaturaService extends AbstractService<FaturaFacade,Fatura> {

	@EJB
	private FaturaFacade faturaFacade;

	@EJB
	private CartaoFacade cartaoFacade;

	@Override
	protected FaturaFacade getFacade() {
		return faturaFacade;
	}

	@GET
	@Path(value = "/cartao/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Fatura> buscarFaturaPorCartaoCredito(@PathParam(value = "id") Long idCartaoCredito) {
		return faturaFacade.buscarFaturaPorCartaoCredito(cartaoFacade.buscarPorId(idCartaoCredito));
	}

	@GET
	@Path(value = "/cartao/pagar/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public void pagarFatura(@PathParam(value = "id") Long idFatura) {

	}

}
