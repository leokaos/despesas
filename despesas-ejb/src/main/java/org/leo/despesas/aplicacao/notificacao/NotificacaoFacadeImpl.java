package org.leo.despesas.aplicacao.notificacao;

import javax.ejb.EJB;
import javax.ejb.Stateless;

import org.leo.despesas.aplicacao.alerta.AlertaFacade;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.notificacao.NotificacaoFiltro;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.exception.DespesasException;

@Stateless
public class NotificacaoFacadeImpl extends AbstractFacade<Notificacao, NotificacaoFiltro> implements NotificacaoFacade {

	@EJB
	private AlertaFacade alertaFacade;

	@Override
	protected Class<Notificacao> getClasseEntidade() {
		return Notificacao.class;
	}

	@Override
	protected String getTopicName() {
		return "notificacao";
	}

	@Override
	protected void preSalvar(Notificacao antigo, Notificacao novo) throws DespesasException {
		novo.setAlerta(alertaFacade.buscarPorId(antigo.getAlerta().getId()));
	}

}
