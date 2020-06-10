package org.leo.despesas.rest.divida;

import javax.ejb.EJB;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.divida.DividaFacade;
import org.leo.despesas.dominio.debitavel.Divida;
import org.leo.despesas.dominio.debitavel.DividaFiltro;
import org.leo.despesas.infra.AbstractService;

@Path(value = "/divida")
public class DividaService extends AbstractService<DividaFacade, Divida, DividaFiltro> {

	@EJB
	private DividaFacade dividaFacade;

	@Override
	protected DividaFacade getFacade() {
		return dividaFacade;
	}

}
