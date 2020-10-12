package org.leo.despesas.rest.servicotransferencia;

import javax.ejb.EJB;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.servicotransferencia.ServicoTransferenciaFacade;
import org.leo.despesas.dominio.servicotransferencia.ServicoTransferencia;
import org.leo.despesas.dominio.servicotransferencia.ServicoTransferenciaFiltro;
import org.leo.despesas.infra.AbstractService;

@Path("/servicotransferencia")
public class ServicoTransferenciaService extends AbstractService<ServicoTransferenciaFacade, ServicoTransferencia, ServicoTransferenciaFiltro> {

	@EJB
	private ServicoTransferenciaFacade facade;

	@Override
	protected ServicoTransferenciaFacade getFacade() {
		return facade;
	}
	
}
