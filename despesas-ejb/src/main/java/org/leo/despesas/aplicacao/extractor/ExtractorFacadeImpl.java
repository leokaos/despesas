package org.leo.despesas.aplicacao.extractor;

import javax.ejb.Stateless;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.Invocation.Builder;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.jboss.resteasy.plugins.providers.multipart.MultipartFormDataOutput;
import org.leo.despesas.dominio.extractor.ExtractVO;
import org.leo.despesas.infra.exception.DespesasException;

@Stateless
public class ExtractorFacadeImpl implements ExtractorFacade {

	private static final String IA_URL = System.getProperty("DESPESAS_IA_URL", "http://localhost:8081");

	@Override
	public ExtractVO extrair(byte[] file, String contentType) throws DespesasException {

		Client client = ClientBuilder.newClient();

		try {
			MultipartFormDataOutput multipart = new MultipartFormDataOutput();
			multipart.addFormData("arquivo", file, MediaType.valueOf(contentType), "upload");

			Builder builder = client.target(IA_URL).path("/").request(MediaType.APPLICATION_JSON);

			Response response = builder.post(Entity.entity(multipart, MediaType.MULTIPART_FORM_DATA_TYPE));

			if (response.getStatus() == 200) {
				return response.readEntity(ExtractVO.class);
			} else {
				String erro = response.readEntity(String.class);
				throw new DespesasException("Erro ao conectar com IA: " + erro);
			}

		} finally {
			client.close();
		}
	}
}