package org.leo.despesas.rest;

import java.io.IOException;

import org.leo.despesas.dominio.debitavel.Debitavel;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

public class DebitavelSerializer extends JsonSerializer<Debitavel> {

	@Override
	public void serialize(Debitavel value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
		System.out.println("leo");
	}

}
