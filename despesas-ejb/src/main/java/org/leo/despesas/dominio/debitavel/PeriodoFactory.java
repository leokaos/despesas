package org.leo.despesas.dominio.debitavel;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.leo.despesas.infra.Periodo;

public class PeriodoFactory {

	public static final DateFormat FORMAT = new SimpleDateFormat("dd-MM-yyyy");

	public static Periodo parse(Map<String, String> mapaAtributos) {

		try {

			Date dataInicial = FORMAT.parse(mapaAtributos.get("dataInicial"));

			Date dataFinal = FORMAT.parse(mapaAtributos.get("dataFinal"));

			return new Periodo(dataInicial, dataFinal);

		} catch (ParseException e) {
			return null;
		}
	}

}
