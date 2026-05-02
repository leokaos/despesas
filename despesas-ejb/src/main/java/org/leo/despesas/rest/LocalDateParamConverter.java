package org.leo.despesas.rest;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import javax.ws.rs.ext.ParamConverter;

public class LocalDateParamConverter implements ParamConverter<LocalDate> {

	private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("EEE, dd MMM yyyy HH:mm:ss zzz", Locale.ENGLISH);

	@Override
	public LocalDate fromString(String value) {

		if (value == null)
			return null;

		try {
			return LocalDate.parse(value, FORMATTER);
		} catch (Exception e2) {
			throw new IllegalArgumentException("Formato de data inválido: " + value);
		}
	}

	@Override
	public String toString(LocalDate value) {
		return value == null ? null : value.toString();
	}

}
