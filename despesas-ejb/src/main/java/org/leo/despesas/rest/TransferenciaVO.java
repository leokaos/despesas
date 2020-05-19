package org.leo.despesas.rest;

import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.dominio.servicotransferencia.Cotacao;
import org.leo.despesas.dominio.servicotransferencia.ServicoTransferencia;

public class TransferenciaVO {

	private Transferencia transferencia;
	private ServicoTransferencia servicoTransferencia;
	private Cotacao cotacao;

	public TransferenciaVO() {
		super();
	}

	public Transferencia getTransferencia() {
		return transferencia;
	}

	public void setTransferencia(Transferencia transferencia) {
		this.transferencia = transferencia;
	}

	public ServicoTransferencia getServicoTransferencia() {
		return servicoTransferencia;
	}

	public void setServicoTransferencia(ServicoTransferencia servicoTransferencia) {
		this.servicoTransferencia = servicoTransferencia;
	}

	public Cotacao getCotacao() {
		return cotacao;
	}

	public void setCotacao(Cotacao cotacao) {
		this.cotacao = cotacao;
	}

}
