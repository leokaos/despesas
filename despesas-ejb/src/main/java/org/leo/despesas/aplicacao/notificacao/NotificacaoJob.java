package org.leo.despesas.aplicacao.notificacao;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Schedule;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.inject.Inject;

import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.notificacao.NotificacaoFiltro;
import org.leo.despesas.infra.notificacao.NotificacaoRepositorio;

@Stateless
public class NotificacaoJob {

	@EJB
	private NotificacaoFacade notificacaoFacade;

	@Inject
	private NotificacaoRepositorio notificacaoRepositorio;

	@Schedule(hour = "9", minute = "0", persistent = false)
	@TransactionAttribute(TransactionAttributeType.REQUIRES_NEW)
	public void executar() {

		NotificacaoFiltro filtro = new NotificacaoFiltro();
		filtro.setExecutado(false);

		List<Notificacao> notificacoes = this.notificacaoFacade.listar(filtro);

		if (!notificacoes.isEmpty()) {
			for (Notificacao notificacao : notificacoes) {
				notificacaoRepositorio.sendNotificacao(notificacao);
			}
		}

	}

}
