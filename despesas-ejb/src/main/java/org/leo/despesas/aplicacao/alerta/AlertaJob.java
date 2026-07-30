package org.leo.despesas.aplicacao.alerta;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Schedule;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.inject.Inject;

import org.leo.despesas.aplicacao.notificacao.NotificacaoFacade;
import org.leo.despesas.dominio.alerta.Alerta;
import org.leo.despesas.infra.alerta.AlertaProcessorVisitor;

@Stateless
public class AlertaJob {

	@EJB
	private AlertaFacade alertaFacade;

	@EJB
	private NotificacaoFacade notificacaoFacade;

	@Inject
	private AlertaProcessorVisitor visitor;

	@Schedule(hour = "1", minute = "0", persistent = false)
	@TransactionAttribute(TransactionAttributeType.REQUIRES_NEW)
	public void executar() {

		List<Alerta> alertas = alertaFacade.listarTodos();

		for (Alerta alerta : alertas) {
			alerta.accept(visitor);
		}

	}

}
