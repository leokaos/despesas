package org.leo.despesas.rest;

import java.io.IOException;
import java.math.BigDecimal;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.DeserializationContext;
import org.codehaus.jackson.map.JsonDeserializer;
import org.leo.despesas.dominio.meta.Meta;
import org.leo.despesas.infra.Mes;

public class MetaDeserializer extends JsonDeserializer<Meta> {

	@Override
	public Meta deserialize(JsonParser jp, DeserializationContext ctxt) throws IOException, JsonProcessingException {

		JsonNode node = jp.getCodec().readTree(jp);

		int mes = node.get("mes").get("mes").getIntValue();
		int ano = node.get("mes").get("ano").getIntValue();

		Meta meta = new Meta();

		meta.setId(node.get("id").getLongValue());
		meta.setMes(new Mes(mes, ano));
		meta.setValor(new BigDecimal(node.get("valor").getBigIntegerValue()));

		return meta;
	}

}
