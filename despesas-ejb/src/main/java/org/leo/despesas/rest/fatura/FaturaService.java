package org.leo.despesas.rest.fatura;

import java.util.List;

import javax.ejb.EJB;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.leo.despesas.aplicacao.cartao.CartaoFacade;
import org.leo.despesas.aplicacao.conta.ContaFacade;
import org.leo.despesas.aplicacao.fatura.FaturaFacade;
import org.leo.despesas.aplicacao.transferencia.TransferenciaFacade;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.rest.infra.AbstractService;

@Path("/fatura")
public class FaturaService extends AbstractService<FaturaFacade,Fatura> {

	@EJB
	private FaturaFacade faturaFacade;

	@EJB
	private CartaoFacade cartaoFacade;

	@EJB
	private ContaFacade contaFacade;

	@EJB
	private TransferenciaFacade transferenciaFacade;

	@Override
	protected FaturaFacade getFacade() {
		return faturaFacade;
	}

	@GET
	@Path(value = "/cartao/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Fatura> buscarFaturaPorCartaoCredito(@PathParam(value = "id") final Long idCartaoCredito) throws DespesasException {
		return faturaFacade.buscarFaturaPorCartaoCredito(cartaoFacade.buscarPorId(idCartaoCredito));
	}

	@GET
	@Path(value = "/pagar/{id}/{conta}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response pagarFatura(@PathParam(value = "id") final Long idFatura,@PathParam(value = "conta") final Long contaId) throws DespesasException {
		transferenciaFacade.pagarFatura(faturaFacade.buscarPorId(idFatura),contaFacade.buscarPorId(contaId));

		return Response.ok().build();
	}

}
