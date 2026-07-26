package org.leo.despesas.rest.alerta;

import javax.ejb.EJB;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.alerta.AlertaFacade;
import org.leo.despesas.dominio.alerta.Alerta;
import org.leo.despesas.dominio.alerta.AlertaFiltro;
import org.leo.despesas.infra.AbstractService;

@Path("/alerta")
public class AlertaService extends AbstractService<AlertaFacade, Alerta, AlertaFiltro> {

	@EJB
	private AlertaFacade alertaFacade;

	@Override
	protected AlertaFacade getFacade() {
		return this.alertaFacade;
	}

}
