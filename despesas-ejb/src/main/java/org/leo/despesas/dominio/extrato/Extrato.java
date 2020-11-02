package org.leo.despesas.dominio.extrato;

import java.io.Serializable;
import java.math.BigDecimal;

public class Extrato implements Serializable {

	private static final long serialVersionUID = 5953607851632323103L;

	private Integer mes;
	private Integer ano;
	private Double entradas;
	private Double saidas;
	private Double transferenciaEntrada;
	private Double transferenciaSaida;

	public Integer getMes() {
		return mes;
	}

	public void setMes(Integer mes) {
		this.mes = mes;
	}

	public Integer getAno() {
		return ano;
	}

	public void setAno(Integer ano) {
		this.ano = ano;
	}

	public Double getEntradas() {
		return entradas;
	}

	public void setEntradas(Double entradas) {
		this.entradas = entradas;
	}

	public Double getSaidas() {
		return saidas;
	}

	public void setSaidas(Double saidas) {
		this.saidas = saidas;
	}

	public Double getTransferenciaEntrada() {
		return transferenciaEntrada;
	}

	public void setTransferenciaEntrada(Double transferenciaEntrada) {
		this.transferenciaEntrada = transferenciaEntrada;
	}

	public Double getTransferenciaSaida() {
		return transferenciaSaida;
	}

	public void setTransferenciaSaida(Double transferenciaSaida) {
		this.transferenciaSaida = transferenciaSaida;
	}

	public Extrato mes(Object mes) {
		this.mes = ((Double) mes).intValue();
		return this;
	}

	public Extrato ano(Object ano) {
		this.ano = ((Double) ano).intValue();
		return this;
	}

	public Extrato entradas(Object entradas) {
		this.entradas = ((BigDecimal) entradas).doubleValue();
		return this;
	}

	public Extrato saidas(Object saidas) {
		this.saidas = ((BigDecimal) saidas).doubleValue();
		return this;
	}

	public Extrato transferenciaEntrada(Object transferenciaEntrada) {
		this.transferenciaEntrada = ((BigDecimal) transferenciaEntrada).doubleValue();
		return this;
	}

	public Extrato transferenciaSaida(Object transferenciaSaida) {
		this.transferenciaSaida = ((BigDecimal) transferenciaSaida).doubleValue();
		return this;
	}

}
