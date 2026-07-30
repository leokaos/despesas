package org.leo.despesas.dominio.notificacao;

import org.leo.despesas.dominio.alerta.Alerta;
import org.leo.despesas.infra.AbstractModelFiltro;
import org.leo.despesas.infra.Mes;

public class NotificacaoFiltro extends AbstractModelFiltro<Notificacao> {

	private Alerta alertaOrigem;

	private boolean executado = false;
	private Mes mes;

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

	public Mes getMes() {
		return mes;
	}

	public void setMes(Mes mes) {
		this.mes = mes;
	}

	@Override
	protected void build() {

		eq("alerta", alertaOrigem);

		eq("executado", executado);
	}

}
