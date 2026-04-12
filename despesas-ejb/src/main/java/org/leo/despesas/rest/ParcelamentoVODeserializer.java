package org.leo.despesas.rest;

import java.io.IOException;
import java.math.BigDecimal;

import org.leo.despesas.dominio.parcelamento.Parcelamento;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.ObjectCodec;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.JsonNode;

public class ParcelamentoVODeserializer extends JsonDeserializer<ParcelamentoVO> {

	private static final String ATRIBUTO_TIPO = "tipo";
	private static final String ATRIBUTO_PARCELAS = "parcelas";

	@Override
	public ParcelamentoVO deserialize(JsonParser jsonParser, DeserializationContext ctxt) throws IOException, JsonProcessingException {

		ObjectCodec oc = jsonParser.getCodec();
		JsonNode node = oc.readTree(jsonParser);

		BigDecimal numeroParcelas = new BigDecimal(node.get(ATRIBUTO_PARCELAS).asText());
		Parcelamento tipoParcelamento = Parcelamento.create(node.get(ATRIBUTO_TIPO).asText());

		return new ParcelamentoVO(tipoParcelamento, numeroParcelas);
	}

}
