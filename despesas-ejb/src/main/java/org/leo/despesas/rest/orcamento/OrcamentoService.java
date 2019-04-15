package org.leo.despesas.rest.orcamento;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.orcamento.OrcamentoFacade;
import org.leo.despesas.dominio.orcamento.Orcamento;
import org.leo.despesas.dominio.orcamento.OrcamentoFiltro;
import org.leo.despesas.rest.infra.AbstractService;

@Path("/orcamento")
@RequestScoped
public class OrcamentoService extends AbstractService<OrcamentoFacade, Orcamento, OrcamentoFiltro> {

	@EJB
	private OrcamentoFacade orcamentoFacade;

	@Override
	protected OrcamentoFacade getFacade() {
		return this.orcamentoFacade;
	}

}
