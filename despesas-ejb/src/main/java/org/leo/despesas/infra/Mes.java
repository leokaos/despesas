package org.leo.despesas.infra;

import java.util.Calendar;
import java.util.Date;

import javax.persistence.Embeddable;

import org.leo.despesas.infra.util.DataUtil;

@Embeddable
//@JsonDeserialize(using = PeriodoDeserializer.class)
public class Mes {

	private Integer mes;
	private Integer ano;

	public Mes() {
		super();
	}

	public Mes(Integer mes, Integer ano) {
		super();

		if (mes < 1 || mes > 12) {
			throw new IllegalArgumentException("Mês deve estar entre 1 e 12");
		}

		if (ano < 0) {
			throw new IllegalArgumentException("Ano deve não pode ser menor que 0.");
		}

		this.mes = mes - 1;
		this.ano = ano;
	}

	public Mes(Date data) {
		super();

		Calendar calendar = DataUtil.toCalendar(data);

		this.mes = calendar.get(Calendar.MONTH);
		this.ano = calendar.get(Calendar.YEAR);
	}

	public String getFormatedString() {
		return new StringBuilder().append(mes).append("/").append(ano).toString();
	}

	public Periodo getPeriodo() {
		Date dataBase = new Date();

		dataBase = DataUtil.setMonths(dataBase, mes);
		dataBase = DataUtil.setYears(dataBase, ano);

		Date dataInicial = DataUtil.truncate(dataBase, Calendar.MONTH);
		Date dataFinal = DataUtil.maximo(dataBase, Calendar.MONTH);

		return new Periodo(dataInicial, dataFinal);
	}

}
