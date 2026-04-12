package org.leo.despesas.aplicacao.telegram;

import javax.ejb.Local;

@Local
public interface TelegramFacade {

	void sendMessage(Long chatId, String text) throws Exception;

	byte[] downloadFile(String filePath) throws Exception;

	String getFilePath(String fileId) throws Exception;

}
