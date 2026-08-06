package org.leo.despesas.rest;

import java.io.Serializable;
import java.time.LocalDate;

import org.leo.despesas.dominio.debitavel.Debitavel;

public class FaturaVO implements Serializable {

	private static final long serialVersionUID = 8460849659987595679L;

	private Debitavel debitavel;
	private LocalDate dataPagamento;

	public Debitavel getDebitavel() {
		return debitavel;
	}

	public void setDebitavel(Debitavel debitavel) {
		this.debitavel = debitavel;
	}

	public LocalDate getDataPagamento() {
		return dataPagamento;
	}

	public void setDataPagamento(LocalDate dataPagamento) {
		this.dataPagamento = dataPagamento;
	}

}
