package org.leo.despesas.aplicacao.telegram;

import javax.ejb.Stateless;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Stateless
public class TelegramFacadeImpl implements TelegramFacade {

	private static final String TOKEN = "8738318487:AAHDOmEQtNlJ--N1_xbovwSpJN7-__AxhOY";//System.getenv("CHAT_TOKEN");
	private static final String API_URL = "https://api.telegram.org/bot" + TOKEN;
	private static final String FILE_API_URL = "https://api.telegram.org/file/bot" + TOKEN;

	@Override
	public String getFilePath(String fileId) throws Exception {

		Client client = ClientBuilder.newClient();

		try {

			Response response = client.target(API_URL + "/getFile").queryParam("file_id", fileId).request(MediaType.APPLICATION_JSON).get();

			String json = response.readEntity(String.class);
			return extractFilePath(json);
		} finally {
			client.close();
		}
	}

	@Override
	public byte[] downloadFile(String filePath) throws Exception {

		Client client = ClientBuilder.newClient();

		try {

			Response response = client.target(FILE_API_URL + "/" + filePath).request().get();

			return response.readEntity(byte[].class);

		} finally {
			client.close();
		}
	}

	@Override
	public void sendMessage(Long chatId, String text) throws Exception {

		Client client = ClientBuilder.newClient();

		try {

			client.target(API_URL + "/sendMessage").queryParam("chat_id", chatId).queryParam("text", text).queryParam("parse_mode", "Markdown").request().get();

		} finally {
			client.close();
		}
	}

	private String extractFilePath(String json) {
		String search = "\"file_path\":\"";
		int start = json.indexOf(search) + search.length();
		int end = json.indexOf("\"", start);
		return json.substring(start, end);
	}

}
