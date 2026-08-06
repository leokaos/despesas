package org.leo.despesas.infra;

import java.time.LocalDate;
import java.util.Objects;

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

	public Mes(LocalDate data) {
		super();
		this.mes = data.getMonthValue();
		this.ano = data.getYear();
	}

	public boolean isNoPassado() {

		LocalDate hoje = LocalDate.now(DataUtil.CLOCK);

		int anoAtual = hoje.getYear();
		int mesAtual = hoje.getMonthValue();

		return this.ano < anoAtual || (this.ano == anoAtual && this.mes < mesAtual);
	}

	public String getFormatedString() {
		return new StringBuilder().append(mes).append("/").append(ano).toString();
	}

	public Periodo getPeriodo() {
		LocalDate data = LocalDate.of(ano, mes, 1);

		LocalDate dataInicial = data.withDayOfMonth(1);
		LocalDate dataFinal = data.withDayOfMonth(data.lengthOfMonth());

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

	public static Mes mesAtual() {
		return new Mes(LocalDate.now(DataUtil.CLOCK));
	}

	@Override
	public boolean equals(Object o) {
		if (this == o)
			return true;
		if (o == null || getClass() != o.getClass())
			return false;
		Mes mesObj = (Mes) o;
		return Objects.equals(mes, mesObj.mes) && Objects.equals(ano, mesObj.ano);
	}

	@Override
	public int hashCode() {
		return Objects.hash(mes, ano);
	}

}
