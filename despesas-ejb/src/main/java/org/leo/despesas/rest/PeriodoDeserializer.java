package org.leo.despesas.rest;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.leo.despesas.dominio.debitavel.PeriodoFactory;
import org.leo.despesas.infra.Periodo;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.JsonNode;

public class PeriodoDeserializer extends JsonDeserializer<Periodo> {

	@Override
	public Periodo deserialize(JsonParser jp, DeserializationContext ctxt) throws IOException, JsonProcessingException {

		JsonNode node = jp.getCodec().readTree(jp);

		Map<String, String> mapaAtributos = new HashMap<String, String>();

		for (Iterator<Entry<String, JsonNode>> fields = node.fields(); fields.hasNext();) {
			Entry<String, JsonNode> entry = fields.next();

			String value = entry.getValue().asText();

			mapaAtributos.put(entry.getKey(), value == "null" ? null : value);
		}

		return PeriodoFactory.parse(mapaAtributos);
	}
}
