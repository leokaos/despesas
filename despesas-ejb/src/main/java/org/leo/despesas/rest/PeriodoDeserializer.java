package org.leo.despesas.rest;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.DeserializationContext;
import org.codehaus.jackson.map.JsonDeserializer;
import org.leo.despesas.dominio.debitavel.PeriodoFactory;
import org.leo.despesas.infra.Periodo;

public class PeriodoDeserializer extends JsonDeserializer<Periodo> {

	@Override
	public Periodo deserialize(JsonParser jp, DeserializationContext ctxt) throws IOException, JsonProcessingException {

		JsonNode node = jp.getCodec().readTree(jp);

		Map<String, String> mapaAtributos = new HashMap<String, String>();

		for (Iterator<Entry<String, JsonNode>> fields = node.getFields(); fields.hasNext();) {
			Entry<String, JsonNode> entry = fields.next();

			String value = entry.getValue().getValueAsText();

			mapaAtributos.put(entry.getKey(), value == "null" ? null : value);
		}

		return PeriodoFactory.parse(mapaAtributos);
	}
}
