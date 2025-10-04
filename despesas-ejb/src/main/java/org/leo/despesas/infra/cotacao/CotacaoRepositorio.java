package org.leo.despesas.infra.cotacao;

import java.math.BigDecimal;
import java.text.MessageFormat;

import javax.ejb.EJB;
import javax.enterprise.context.ApplicationScoped;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.jboss.resteasy.client.ClientRequest;
import org.leo.despesas.aplicacao.parametro.ParametroFacade;
import org.leo.despesas.infra.Moeda;

@ApplicationScoped
public class CotacaoRepositorio {

	private static final String PARAMETRO_FORMAT = "{0}{1}-{2}";

	@EJB
	private ParametroFacade parametroFacade;

	public BigDecimal getCotacao(Moeda origem, Moeda destino) {

		try {

			String baseURL = parametroFacade.getUrlParaCotacao();

			String url = MessageFormat.format(PARAMETRO_FORMAT, baseURL, origem.getCodigo(), destino.getCodigo());

			ClientRequest request = new ClientRequest(url);

			String rawJson = request.get(String.class).getEntity();

			JsonNode json = new ObjectMapper().readTree(rawJson);

			JsonNode findNode = json.get(origem.getCodigo() + destino.getCodigo());

			return findNode != null ? new BigDecimal(findNode.get("bid").getValueAsText()) : null;

		} catch (Exception e) {
			return null;
		}

	}

}
