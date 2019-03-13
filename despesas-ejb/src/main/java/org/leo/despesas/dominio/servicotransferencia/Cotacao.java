package org.leo.despesas.dominio.servicotransferencia;

import java.math.BigDecimal;
import java.util.Date;

public class Cotacao {

	private Moeda origem;

	private Moeda destino;

	private BigDecimal rate;

	private Date data;

	public Cotacao() {
		super();
	}

	public Moeda getOrigem() {
		return origem;
	}

	public void setOrigem(Moeda origem) {
		this.origem = origem;
	}

	public Moeda getDestino() {
		return destino;
	}

	public void setDestino(Moeda destino) {
		this.destino = destino;
	}

	public BigDecimal getRate() {
		return rate;
	}

	public void setRate(BigDecimal rate) {
		this.rate = rate;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

}
