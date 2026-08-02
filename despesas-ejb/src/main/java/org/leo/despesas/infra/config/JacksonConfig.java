package org.leo.despesas.infra.config;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.ws.rs.ext.ContextResolver;
import javax.ws.rs.ext.Provider;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;

@Provider
public class JacksonConfig implements ContextResolver<ObjectMapper> {

	private final ObjectMapper mapper;

	public JacksonConfig() {

		mapper = new ObjectMapper();

		JavaTimeModule timeModule = new JavaTimeModule();

		timeModule.addSerializer(LocalDate.class, new LocalDateSerializer(DateTimeFormatter.ofPattern("yyyy-MM-dd")));

		mapper.registerModule(timeModule);
		mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	}

	@Override
	public ObjectMapper getContext(Class<?> type) {
		return mapper;
	}
}