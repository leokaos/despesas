package org.leo.despesas.rest.despesa;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.codehaus.jackson.map.ObjectMapper;
import org.leo.despesas.aplicacao.despesa.DespesaFacade;
import org.leo.despesas.aplicacao.extractor.ExtractorFacade;
import org.leo.despesas.aplicacao.telegram.TelegramFacade;
import org.leo.despesas.dominio.extractor.ExtractVO;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.telegram.telegrambots.meta.api.objects.Message;
import org.telegram.telegrambots.meta.api.objects.PhotoSize;
import org.telegram.telegrambots.meta.api.objects.Update;

@Path("/despesa/chat")
@RequestScoped
public class DespesaChatService {

	@EJB
	private TelegramFacade telegramFacade;

	@EJB
	private ExtractorFacade extractorFacade;
	
	@EJB
	private DespesaFacade despesaFacade;

	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	public Response hook(Update update) {
		
		System.out.println(">>> Recebi um Update: " + update.getUpdateId());

		Message message = update.getMessage();

		if (message == null) {
			return Response.ok().build();
		}

		Long chatId = message.getChatId();

		try {

			String fileId = null;
			String contentType = null;

			if (message.hasPhoto()) {
				PhotoSize photo = message.getPhoto().get(message.getPhoto().size() - 1);
				fileId = photo.getFileId();
				contentType = "image/jpeg";
			} else if (message.hasDocument()) {
				fileId = message.getDocument().getFileId();
				contentType = message.getDocument().getMimeType();
			} else {
				telegramFacade.sendMessage(chatId, "Envie uma imagem ou PDF");
				return Response.ok().build();
			}

			String filePath = telegramFacade.getFilePath(fileId);
			byte[] arquivo = telegramFacade.downloadFile(filePath);

			ExtractVO resultado = extractorFacade.extrair(arquivo, contentType);
			Despesa despesa = despesaFacade.createFromExtraction(resultado);
			
			telegramFacade.sendMessage(chatId, new ObjectMapper().writeValueAsString(despesa));

		} catch (Exception e) {
			try {
				telegramFacade.sendMessage(chatId, "Erro: " + e.getMessage());
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		return Response.ok().build();
	}

}
