package org.leo.despesas.rest;

import java.io.IOException;
import java.util.Date;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.DeserializationContext;
import org.codehaus.jackson.map.JsonDeserializer;
import org.leo.despesas.infra.Periodo;

public class PeriodoDeserializer extends JsonDeserializer<Periodo> {

	@Override
	public Periodo deserialize(JsonParser jp, DeserializationContext ctxt) throws IOException, JsonProcessingException {

		JsonNode node = jp.getCodec().readTree(jp);

		JsonNode dataInicial = node.get("dataInicial");
		JsonNode dataFinal = node.get("dataFinal");

		if (dataFinal != null && dataInicial != null) {
			return new Periodo(new Date(dataInicial.getValueAsText()), new Date(dataFinal.getTextValue()));
		} else {
			return null;
		}
	}
}
