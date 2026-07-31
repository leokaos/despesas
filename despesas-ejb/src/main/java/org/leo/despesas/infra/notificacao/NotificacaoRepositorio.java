package org.leo.despesas.infra.notificacao;

import java.text.MessageFormat;

import javax.enterprise.context.ApplicationScoped;

import org.leo.despesas.dominio.notificacao.Notificacao;

import com.pengrad.telegrambot.TelegramBot;
import com.pengrad.telegrambot.request.SendMessage;
import com.pengrad.telegrambot.response.SendResponse;

@ApplicationScoped
public class NotificacaoRepositorio {

	private static final String MESSAGE_FORMAT = "Data limite {0} para {1}!";

	private static final String BOT_TOKEN_ENV = "TELEGRAM_BOT_TOKEN";
	private static final String CHAT_ID_ENV = "TELEGRAM_CHAT_ID";

	private static String BOT_TOKEN;
	private static String CHAT_ID;

	static {
		BOT_TOKEN = System.getProperty(BOT_TOKEN_ENV, System.getenv(BOT_TOKEN_ENV));
		CHAT_ID = System.getProperty(CHAT_ID_ENV, System.getenv(CHAT_ID_ENV));
	}

	public void sendNotificacao(Notificacao notificacao) {
		sendMessage(MessageFormat.format(MESSAGE_FORMAT, notificacao.getTargetDate(), notificacao.getAlerta().getDescricao()));
	}

	private void sendMessage(String message) {

		TelegramBot bot = new TelegramBot(BOT_TOKEN);

		SendMessage request = new SendMessage(CHAT_ID, message);
		SendResponse response = bot.execute(request);

		if (response.isOk()) {
			System.out.println("Mensagem enviada com sucesso!");
		} else {
			System.out.println("Erro ao enviar mensagem: " + response.errorCode());
		}

	}

}
