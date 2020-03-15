package org.leo.despesas.rest.meta;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.meta.MetaFacade;
import org.leo.despesas.dominio.meta.Meta;
import org.leo.despesas.dominio.meta.MetaFiltro;
import org.leo.despesas.rest.infra.AbstractService;

@Path("/meta")
@RequestScoped
public class MetaService extends AbstractService<MetaFacade, Meta, MetaFiltro> {

	@Inject
	private MetaFacade metaFacade;

	@Override
	protected MetaFacade getFacade() {
		return this.metaFacade;
	}

}
