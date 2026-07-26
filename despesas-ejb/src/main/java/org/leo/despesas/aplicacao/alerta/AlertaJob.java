package org.leo.despesas.aplicacao.alerta;

import java.util.List;
import java.util.Optional;

import javax.ejb.EJB;
import javax.ejb.Schedule;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;

import org.leo.despesas.aplicacao.notificacao.NotificacaoFacade;
import org.leo.despesas.dominio.alerta.Alerta;
import org.leo.despesas.dominio.alerta.AlertaFiltro;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.notificacao.NotificacaoFiltro;
import org.leo.despesas.infra.exception.DespesasException;

@Stateless
public class AlertaJob {

	@EJB
	private AlertaFacade alertaFacade;

	@EJB
	private NotificacaoFacade notificacaoFacade;

	@Schedule(hour = "1", minute = "0", persistent = false)
	@TransactionAttribute(TransactionAttributeType.REQUIRES_NEW)
	public void executar() {

		System.out.println("JOB ALERTA - INICIO");

		List<Alerta> alertas = alertaFacade.listar(new AlertaFiltro());

		for (Alerta alerta : alertas) {

			System.out.println("PROCESSANDO ALERTA: " + alerta.getDescricao());

			NotificacaoFiltro filtro = new NotificacaoFiltro();
			filtro.setAlertaOrigem(alerta);
			filtro.setExecutado(false);

			List<Notificacao> notificacoesEmAberto = notificacaoFacade.listar(filtro);

			if (notificacoesEmAberto.isEmpty()) {
				System.out.println("CRIANDO NOTIFICACAO PARA: " + alerta.getDescricao());
				criarNotificacao(alerta);
			}
		}

		System.out.println("JOB ALERTA - FIM");
	}

	private void criarNotificacao(Alerta alerta) {

		try {

			Optional<Notificacao> novaNotificacao = alerta.gerarNotificacao();

			if (novaNotificacao.isPresent()) {
				notificacaoFacade.inserir(novaNotificacao.get());
			}

		} catch (DespesasException e) {
			System.out.println("Erro ao gerar notificacao!" + e.getMessage());
		}

	}

}
