package org.leo.despesas.rest.ativo;

import javax.ejb.EJB;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.ativo.AtivoFacade;
import org.leo.despesas.dominio.debitavel.Ativo;
import org.leo.despesas.dominio.debitavel.AtivoFiltro;
import org.leo.despesas.infra.AbstractService;

@Path("/ativo")
public class AtivoService extends AbstractService<AtivoFacade, Ativo, AtivoFiltro> {

	@EJB
	private AtivoFacade ativoFacade;

	@Override
	protected AtivoFacade getFacade() {
		return this.ativoFacade;
	}

}
