package org.leo.despesas.rest.fatura;

import java.util.List;

import javax.ejb.EJB;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.leo.despesas.aplicacao.cartao.CartaoFacade;
import org.leo.despesas.aplicacao.conta.ContaFacade;
import org.leo.despesas.aplicacao.fatura.FaturaFacade;
import org.leo.despesas.aplicacao.transferencia.TransferenciaFacade;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.rest.FaturaVO;

@Path("/cartao/{id}/fatura")
public class FaturaService {

	@EJB
	private FaturaFacade faturaFacade;

	@EJB
	private CartaoFacade cartaoFacade;

	@EJB
	private ContaFacade contaFacade;

	@EJB
	private TransferenciaFacade transferenciaFacade;

	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public List<Fatura> buscarFaturaPorCartaoCredito(@PathParam(value = "id") final Long idCartaoCredito) throws DespesasException {
		return faturaFacade.buscarFaturaPorCartaoCredito(cartaoFacade.buscarPorId(idCartaoCredito));
	}

	@PUT
	@Path("/{fatura-id}")
	@Consumes(value = MediaType.APPLICATION_JSON)
	@Produces(value = MediaType.APPLICATION_JSON)
	public Response salvar(final FaturaVO faturaVO, @PathParam(value = "fatura-id") final Long id) throws DespesasException {

		Fatura fatura = faturaFacade.buscarPorId(id);
		Conta conta = contaFacade.buscarPorId(faturaVO.getDebitavel().getId());

		transferenciaFacade.pagarFatura(fatura, conta, faturaVO.getDataPagamento());

		return Response.ok().build();
	}

}
