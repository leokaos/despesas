package org.leo.despesas.rest.projecao;

import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.infra.Periodo;

public final class ProjecaoVO {

	private Debitavel debitavel;
	private Periodo periodo;

	public ProjecaoVO() {
		super();
	}

	public Debitavel getDebitavel() {
		return debitavel;
	}

	public void setDebitavel(Debitavel debitavel) {
		this.debitavel = debitavel;
	}

	public Periodo getPeriodo() {
		return periodo;
	}

	public void setPeriodo(Periodo periodo) {
		this.periodo = periodo;
	}

}
