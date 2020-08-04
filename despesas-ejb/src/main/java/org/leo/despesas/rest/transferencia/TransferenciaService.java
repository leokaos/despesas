package org.leo.despesas.rest.transferencia;

import javax.ejb.EJB;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.leo.despesas.aplicacao.transferencia.TransferenciaFacade;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.dominio.movimentacao.TransferenciaFiltro;
import org.leo.despesas.infra.AbstractService;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.rest.TransferenciaVO;

@Path(value = "/transferencia")
public class TransferenciaService extends AbstractService<TransferenciaFacade, Transferencia, TransferenciaFiltro> {

	@EJB
	private TransferenciaFacade transferenciaFacade;

	@POST
	@Consumes(value = MediaType.APPLICATION_JSON)
	public Response inserir(final TransferenciaVO transferenciaVO) throws DespesasException {

		Transferencia transferencia = transferenciaFacade.inserir(transferenciaVO.getTransferencia(), transferenciaVO.getServicoTransferencia(), transferenciaVO.getCotacao());

		return Response.ok(transferencia).build();
	}

	@Override
	public Response inserir(final Transferencia t) {
		return Response.noContent().build();
	}

	@Override
	protected TransferenciaFacade getFacade() {
		return transferenciaFacade;
	}

}
