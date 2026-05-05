package org.leo.despesas.services;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.enterprise.event.Observes;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.leo.despesas.infra.eventos.EntidadeEvent;

import com.fasterxml.jackson.databind.ObjectMapper;

@ServerEndpoint("/socket/{topico}")
public class EventHandler {

	private static Map<String, Set<Session>> topicos = new ConcurrentHashMap<>();
	private static ObjectMapper MAPPER = new ObjectMapper();

	@OnOpen
	public void onOpen(@PathParam("topico") String topico, Session session) {
		topicos.computeIfAbsent(topico, k -> Collections.synchronizedSet(new HashSet<Session>())).add(session);
	}

	@OnMessage
	public void onMessage(@PathParam("topico") String topico, String mensagem, Session session) {
		System.out.println("Mensagem recebida no tópico [" + topico + "]: " + mensagem);
	}

	@OnClose
	public void onClose(@PathParam("topico") String topico, Session session) {

		Set<Session> inscritos = topicos.get(topico);

		if (inscritos != null) {
			inscritos.remove(session);
		}
	}

	@OnError
	public void onError(@PathParam("topico") String topico, Session session, Throwable t) {
		System.out.println("Erro no tópico [" + topico + "]: " + t.getMessage());
	}

	public void onMessageEvent(@Observes EntidadeEvent event) {

		Set<Session> inscritos = topicos.get(event.getTopic());

		if (inscritos != null) {

			synchronized (inscritos) {
				for (Session s : inscritos) {
					if (s.isOpen()) {
						try {
							s.getBasicRemote().sendText(MAPPER.writeValueAsString(event));
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}

	}

}