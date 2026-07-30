package org.leo.despesas.aplicacao.notificacao;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.notificacao.NotificacaoFiltro;
import org.leo.despesas.infra.AbstractFacade;

@Stateless
public class NotificacaoFacadeImpl extends AbstractFacade<Notificacao, NotificacaoFiltro> implements NotificacaoFacade {

	@Override
	protected Class<Notificacao> getClasseEntidade() {
		return Notificacao.class;
	}

	@Override
	protected String getTopicName() {
		return "notificacao";
	}

}
