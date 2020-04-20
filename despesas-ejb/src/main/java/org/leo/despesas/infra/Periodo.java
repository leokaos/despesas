package org.leo.despesas.infra;

import static java.util.Calendar.DAY_OF_MONTH;
import static org.apache.commons.lang3.time.DateUtils.truncate;

import java.util.Date;
import java.util.Iterator;

import javax.persistence.Embeddable;

import org.apache.commons.lang3.time.DateUtils;
import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.leo.despesas.rest.PeriodoDeserializer;

@Embeddable
@JsonDeserialize(using = PeriodoDeserializer.class)
public class Periodo {

	private Date dataInicial;
	private Date dataFinal;

	public Periodo() {
		super();
	}

	public Periodo(Date dataInicial, Date dataFinal) {
		super();
		this.dataInicial = dataInicial;
		this.dataFinal = dataFinal;
	}

	public Date getDataInicial() {
		return dataInicial;
	}

	public Date getDataFinal() {
		return dataFinal;
	}

	@Override
	public String toString() {
		return new StringBuilder().append(dataInicial).append(" - ").append(dataFinal).toString();
	}

	public boolean pertenceAoPeriodo(Date dataBase) {
		return dataInicial.before(dataBase) && dataFinal.after(dataBase);
	}

	public int getDiasParaTermino() {

		int dias = 0;

		Date data = new Date();
		Date dataFinalTruncada = truncate(dataFinal, DAY_OF_MONTH);

		while (data.before(dataFinalTruncada)) {
			dias++;
			data = DateUtils.addDays(data, 1);
		}

		return dias;
	}

	public Iterator<Date> getIterator(int field) {
		return new PeriodoIterator(field, this);
	}
}
