package org.leo.despesas.rest.fatura;

import javax.ejb.EJB;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.transferencia.TransferenciaFacade;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.rest.infra.AbstractService;

@Path(value = "/transferencia")
public class TransferenciaService extends AbstractService<TransferenciaFacade,Transferencia> {

	@EJB
	private TransferenciaFacade transferenciaFacade;

	@Override
	protected TransferenciaFacade getFacade() {
		return transferenciaFacade;
	}

}
