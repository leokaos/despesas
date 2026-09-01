package org.leo.despesas.infra;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Iterator;

import javax.persistence.Embeddable;

import org.leo.despesas.infra.util.DataUtil;
import org.leo.despesas.rest.PeriodoDeserializer;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;

@Embeddable
@JsonDeserialize(using = PeriodoDeserializer.class)
public class Periodo {

	private LocalDate dataInicial;
	private LocalDate dataFinal;

	public Periodo() {
		super();
	}

	public Periodo(LocalDate dataInicial, LocalDate dataFinal) {
		super();
		this.dataInicial = dataInicial;
		this.dataFinal = dataFinal;
	}

	public LocalDate getDataInicial() {
		return dataInicial;
	}

	public void setDataInicial(LocalDate dataInicial) {
		this.dataInicial = dataInicial;
	}

	public LocalDate getDataFinal() {
		return dataFinal;
	}

	public void setDataFinal(LocalDate dataFinal) {
		this.dataFinal = dataFinal;
	}

	@Override
	public String toString() {
		return new StringBuilder().append(dataInicial).append(" - ").append(dataFinal).toString();
	}

	public boolean pertenceAoPeriodo(LocalDate dataBase) {
		return !dataBase.isBefore(dataInicial) && !dataBase.isAfter(dataFinal);
	}

	public int getDiasParaTermino() {
		return (int) ChronoUnit.DAYS.between(LocalDate.now(DataUtil.CLOCK), dataFinal) + 1;
	}

	public Iterator<LocalDate> getIterator(ChronoUnit field) {
		return new PeriodoIterator(field, this);
	}
}
