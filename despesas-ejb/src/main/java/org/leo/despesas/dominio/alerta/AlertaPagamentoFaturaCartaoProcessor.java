package org.leo.despesas.dominio.alerta;

import java.util.List;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

import org.leo.despesas.aplicacao.notificacao.NotificacaoFacade;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.notificacao.NotificacaoFiltro;
import org.leo.despesas.infra.exception.DespesasException;

@ApplicationScoped
public class AlertaPagamentoFaturaCartaoProcessor implements AlertaProcessor<AlertaPagamentoFaturaCartao> {

	@Inject
	private NotificacaoFacade notificacaoFacade;

	@Override
	public void processarAlerta(AlertaPagamentoFaturaCartao alerta) {

		try {
			
			NotificacaoFiltro filtro = new NotificacaoFiltro();
			filtro.setAlertaOrigem(alerta);
			filtro.setExecutado(false);

			List<Notificacao> notificacoes = this.notificacaoFacade.listar(filtro);

			if (notificacoes.isEmpty() && alerta.isProximaFaturaNosProximosDias()) {
				notificacaoFacade.inserir(alerta.gerarNotificacao());
			}

		} catch (DespesasException e) {
			System.out.println(e);
		}

	}

}
