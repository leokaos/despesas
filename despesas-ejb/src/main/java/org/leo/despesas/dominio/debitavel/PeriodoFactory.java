package org.leo.despesas.dominio.debitavel;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import org.leo.despesas.infra.Periodo;

public class PeriodoFactory {

	public static final DateTimeFormatter FORMAT = DateTimeFormatter.ofPattern("dd-MM-yyyy");

	public static Periodo parse(Map<String, String> mapaAtributos) {

		try {
			String dataInicialStr = mapaAtributos.get("dataInicial");
			String dataFinalStr = mapaAtributos.get("dataFinal");

			if (dataInicialStr == null || dataFinalStr == null) {
				return null;
			}

			LocalDate dataInicial = LocalDate.parse(dataInicialStr, FORMAT);
			LocalDate dataFinal = LocalDate.parse(dataFinalStr, FORMAT);

			return new Periodo(dataInicial, dataFinal);

		} catch (Exception e) {
			return null;
		}
	}
}