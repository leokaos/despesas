package org.leo.despesas.rest;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.ws.rs.ext.ParamConverter;

public class LocalDateParamConverter implements ParamConverter<LocalDate> {

	private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

	@Override
	public LocalDate fromString(String value) {

		if (value == null)
			return null;

		try {
			return LocalDate.parse(value, FORMATTER);
		} catch (Exception e) {
			throw new IllegalArgumentException("Formato de data inválido: " + value);
		}
	}

	@Override
	public String toString(LocalDate value) {
		return value == null ? null : value.toString();
	}

}
