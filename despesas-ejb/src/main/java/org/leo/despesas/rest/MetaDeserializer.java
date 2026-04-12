package org.leo.despesas.rest;

import java.io.IOException;
import java.math.BigDecimal;

import org.leo.despesas.dominio.meta.Meta;
import org.leo.despesas.infra.Mes;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.JsonNode;

public class MetaDeserializer extends JsonDeserializer<Meta> {

	@Override
	public Meta deserialize(JsonParser jp, DeserializationContext ctxt) throws IOException, JsonProcessingException {

		JsonNode node = jp.getCodec().readTree(jp);

		int mes = node.get("mes").get("mes").asInt();
		int ano = node.get("mes").get("ano").asInt();

		Meta meta = new Meta();

		if (node.get("id") != null) {
			meta.setId(node.get("id").asLong());
		}

		meta.setMes(new Mes(mes, ano));
		meta.setValor(new BigDecimal(node.get("valor").asDouble()));

		return meta;
	}

}
