package org.leo.despesas.infra.cotacao;

import java.math.BigDecimal;
import java.text.MessageFormat;

import javax.ejb.EJB;
import javax.enterprise.context.ApplicationScoped;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.core.MediaType;

import org.leo.despesas.aplicacao.parametro.ParametroFacade;
import org.leo.despesas.infra.Moeda;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@ApplicationScoped
public class CotacaoRepositorio {

	private static final String PARAMETRO_FORMAT = "{0}{1}-{2}";

	@EJB
	private ParametroFacade parametroFacade;

	private Client client = ClientBuilder.newClient();

	private ObjectMapper mapper = new ObjectMapper();

	public BigDecimal getCotacao(Moeda origem, Moeda destino) {

		try {
			String baseURL = parametroFacade.getUrlParaCotacao();
			String url = MessageFormat.format(PARAMETRO_FORMAT, baseURL, origem.getCodigo(), destino.getCodigo());

			String rawJson = client.target(url).request(MediaType.APPLICATION_JSON).get(String.class);

			JsonNode json = mapper.readTree(rawJson);
			String chave = origem.getCodigo() + destino.getCodigo();
			JsonNode findNode = json.get(chave);

			if (findNode != null && findNode.has("bid")) {
				return new BigDecimal(findNode.get("bid").asText());
			}

			return null;

		} catch (Exception e) {
			System.err.println("Erro ao obter cotação: " + e.getMessage());
			return null;
		}

	}

}
