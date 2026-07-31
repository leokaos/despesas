package org.leo.despesas.aplicacao.alerta;

import javax.ejb.EJB;
import javax.ejb.Schedule;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;

import org.leo.despesas.infra.exception.DespesasException;

@Stateless
public class AlertaJob {

	@EJB
	private AlertaFacade alertaFacade;

	@Schedule(hour = "1", minute = "0", persistent = false)
	@TransactionAttribute(TransactionAttributeType.REQUIRES_NEW)
	public void executar() {
		try {
			this.alertaFacade.gerarNotificacoes();
		} catch (DespesasException e) {
			System.out.println("Erro ao gerar notificacaoes!");
		}
	}

}
