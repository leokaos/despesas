package org.leo.despesas.dominio.notificacao;

import java.time.LocalDate;

import org.leo.despesas.dominio.alerta.Alerta;
import org.leo.despesas.infra.AbstractModelFiltro;

public class NotificacaoFiltro extends AbstractModelFiltro<Notificacao> {

	private Alerta alertaOrigem;
	private Boolean executado;
	private LocalDate targetDate;

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

	public LocalDate getTargetDate() {
		return targetDate;
	}

	public void setTargetDate(LocalDate targetDate) {
		this.targetDate = targetDate;
	}

	@Override
	protected void build() {

		eq("alerta", alertaOrigem);

		eq("executado", executado);

		eq("targetDate", targetDate);
	}

}
