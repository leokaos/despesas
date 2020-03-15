package org.leo.despesas.dominio.movimentacao;

import java.util.Date;

import org.leo.despesas.infra.AbstractModelFiltro;

public class TransferenciaFiltro extends AbstractModelFiltro<Transferencia> {

	private Date dataInicial;
	private Date dataFinal;

	public TransferenciaFiltro() {
		super();
	}

	public Date getDataInicial() {
		return dataInicial;
	}

	public void setDataInicial(final Date dataInicial) {
		this.dataInicial = dataInicial;
	}

	public Date getDataFinal() {
		return dataFinal;
	}

	public void setDataFinal(final Date dataFinal) {
		this.dataFinal = dataFinal;
	}

	public boolean hasDataInicialAndDataFinal() {
		return dataInicial != null && dataFinal != null;
	}

	public boolean hasDataInicial() {
		return dataInicial != null;
	}

	public boolean hasDataFinal() {
		return dataFinal != null;
	}

}
