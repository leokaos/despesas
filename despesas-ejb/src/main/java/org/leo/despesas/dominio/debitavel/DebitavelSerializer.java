package org.leo.despesas.dominio.debitavel;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.SerializerProvider;

public class DebitavelSerializer extends JsonSerializer<Debitavel> {

	@Override
	public void serialize(Debitavel value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
		System.out.println("leo");
	}

}
