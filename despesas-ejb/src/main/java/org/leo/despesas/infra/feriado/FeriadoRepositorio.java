package org.leo.despesas.infra.feriado;

import java.text.MessageFormat;
import java.util.Arrays;
import java.util.List;

import javax.ejb.EJB;
import javax.enterprise.context.ApplicationScoped;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.core.MediaType;

import org.leo.despesas.aplicacao.parametro.ParametroFacade;

import com.fasterxml.jackson.databind.ObjectMapper;

@ApplicationScoped
public class FeriadoRepositorio {

	private static final String PARAMETRO_FORMAT = "{0}{1}/PT";

	@EJB
	private ParametroFacade parametroFacade;

	private Client client = ClientBuilder.newClient();

	private ObjectMapper mapper = new ObjectMapper();

	public List<FeriadoDTO> getFeriadosPelaApi(Integer ano) {

		try {

			String baseURL = parametroFacade.getUrlParaFeriados();
			String url = MessageFormat.format(PARAMETRO_FORMAT, baseURL, ano.toString());

			String response = client.target(url).request(MediaType.APPLICATION_JSON).get(String.class);

			FeriadoDTO[] feriadosArray = mapper.readValue(response, FeriadoDTO[].class);
			List<FeriadoDTO> feriados = Arrays.asList(feriadosArray);

			return feriados;

		} catch (Exception e) {
			System.err.println("Erro ao obter feriados: " + e.getMessage());
			return null;
		}

	}

}
