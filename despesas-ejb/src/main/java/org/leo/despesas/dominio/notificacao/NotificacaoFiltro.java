package org.leo.despesas.dominio.notificacao;

import org.leo.despesas.dominio.alerta.Alerta;
import org.leo.despesas.infra.AbstractModelFiltro;

public class NotificacaoFiltro extends AbstractModelFiltro<Notificacao> {

	private Alerta alertaOrigem;

	private boolean executado = false;

	public NotificacaoFiltro() {
		super();
	}

	public Alerta getAlertaOrigem() {
		return alertaOrigem;
	}

	public void setAlertaOrigem(Alerta alertaOrigem) {
		this.alertaOrigem = alertaOrigem;
	}

	public boolean isExecutado() {
		return executado;
	}

	public void setExecutado(boolean executado) {
		this.executado = executado;
	}

	@Override
	protected void build() {

		eq("alerta", alertaOrigem);

		eq("executado", executado);
	}

}
