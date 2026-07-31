package org.leo.despesas.dominio.alerta;

import java.util.List;

import javax.ejb.EJB;
import javax.enterprise.context.ApplicationScoped;

import org.leo.despesas.aplicacao.notificacao.NotificacaoFacade;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.notificacao.NotificacaoFiltro;
import org.leo.despesas.infra.exception.DespesasException;

@ApplicationScoped
public class AlertaLimitePagamentoDividaProcessor implements AlertaProcessor<AlertaLimitePagamentoDivida> {

	@EJB
	private NotificacaoFacade notificacaoFacade;

	@Override
	public void processarAlerta(AlertaLimitePagamentoDivida alerta) {

		try {

			if (alerta.getDivida().isAtivo() && alerta.isDataLimiteDividaProximosDias()) {

				NotificacaoFiltro filtro = new NotificacaoFiltro();
				filtro.setAlertaOrigem(alerta);
				filtro.setExecutado(false);

				List<Notificacao> notificacoes = this.notificacaoFacade.listar(filtro);

				if (notificacoes.isEmpty()) {
					notificacaoFacade.inserir(alerta.gerarNotificacao());
				}
			}

		} catch (DespesasException e) {
			System.out.println(e);
		}
	}

}