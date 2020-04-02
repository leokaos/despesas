package org.leo.despesas.infra;

import java.util.Calendar;
import java.util.Date;

import javax.persistence.Embeddable;

import org.leo.despesas.infra.util.DataUtil;

@Embeddable
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

		this.mes = mes;
		this.ano = ano;
	}

	public Mes(Date data) {
		super();

		Calendar calendar = DataUtil.toCalendar(data);

		this.mes = calendar.get(Calendar.MONTH) + 1;
		this.ano = calendar.get(Calendar.YEAR);
	}

	public String getFormatedString() {
		return new StringBuilder().append(mes).append("/").append(ano).toString();
	}

	public Periodo getPeriodo() {

		Calendar calendar = Calendar.getInstance();

		calendar.set(Calendar.MONTH, mes - 1);
		calendar.set(Calendar.YEAR, ano);

		Date dataInicial = DataUtil.truncate(calendar.getTime(), Calendar.MONTH);
		Date dataFinal = DataUtil.maximo(calendar.getTime(), Calendar.MONTH);

		return new Periodo(dataInicial, dataFinal);
	}

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

}
