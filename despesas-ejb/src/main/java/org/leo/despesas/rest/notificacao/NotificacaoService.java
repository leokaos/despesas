package org.leo.despesas.rest.notificacao;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Path;

import org.leo.despesas.aplicacao.notificacao.NotificacaoFacade;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.notificacao.NotificacaoFiltro;
import org.leo.despesas.infra.AbstractService;

@Path("/notificacao")
@RequestScoped
public class NotificacaoService extends AbstractService<NotificacaoFacade, Notificacao, NotificacaoFiltro> {

	@EJB
	private NotificacaoFacade notificacaoFacade;

	@Override
	protected NotificacaoFacade getFacade() {
		return this.notificacaoFacade;
	}

}
