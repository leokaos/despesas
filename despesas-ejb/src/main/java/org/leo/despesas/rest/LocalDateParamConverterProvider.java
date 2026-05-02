package org.leo.despesas.rest;

import java.lang.annotation.Annotation;
import java.lang.reflect.Type;
import java.time.LocalDate;

import javax.ws.rs.ext.ParamConverter;
import javax.ws.rs.ext.ParamConverterProvider;
import javax.ws.rs.ext.Provider;

@Provider
public class LocalDateParamConverterProvider implements ParamConverterProvider {

	private final LocalDateParamConverter converter = new LocalDateParamConverter();

	@Override
	@SuppressWarnings("unchecked")
	public <T> ParamConverter<T> getConverter(Class<T> rawType, Type genericType, Annotation[] annotations) {

		if (rawType.equals(LocalDate.class)) {
			return (ParamConverter<T>) converter;
		}

		return null;
	}

}
