package org.leo.despesas.dominio.parcelamento;

import java.io.IOException;
import java.math.BigDecimal;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.ObjectCodec;
import org.codehaus.jackson.map.DeserializationContext;
import org.codehaus.jackson.map.JsonDeserializer;

public class ParcelamentoVODeserialize extends JsonDeserializer<ParcelamentoVO> {

	private static final String ATRIBUTO_TIPO = "tipo";
	private static final String ATRIBUTO_PARCELAS = "parcelas";

	@Override
	public ParcelamentoVO deserialize(JsonParser jsonParser,DeserializationContext ctxt) throws IOException,JsonProcessingException {

		ObjectCodec oc = jsonParser.getCodec();
		JsonNode node = oc.readTree(jsonParser);

		BigDecimal numeroParcelas = new BigDecimal(node.get(ATRIBUTO_PARCELAS).getTextValue());
		Parcelamento tipoParcelamento = Parcelamento.create(node.get(ATRIBUTO_TIPO).getTextValue());

		return new ParcelamentoVO(tipoParcelamento,numeroParcelas);
	}

}
