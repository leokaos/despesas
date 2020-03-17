package org.leo.despesas.rest;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.SerializerProvider;
import org.leo.despesas.dominio.debitavel.Debitavel;

public class DebitavelSerializer extends JsonSerializer<Debitavel> {

	@Override
	public void serialize(Debitavel value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
		System.out.println("leo");
	}

}
