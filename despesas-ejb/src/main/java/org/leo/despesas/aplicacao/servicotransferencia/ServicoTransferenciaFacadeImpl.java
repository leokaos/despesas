package org.leo.despesas.aplicacao.servicotransferencia;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.servicotransferencia.ServicoTransferencia;
import org.leo.despesas.rest.infra.AbstractFacade;

@Stateless
public class ServicoTransferenciaFacadeImpl extends AbstractFacade<ServicoTransferencia> implements ServicoTransferenciaFacade {

	@Override
	protected Class<ServicoTransferencia> getClasseEntidade() {
		return ServicoTransferencia.class;
	}

}
