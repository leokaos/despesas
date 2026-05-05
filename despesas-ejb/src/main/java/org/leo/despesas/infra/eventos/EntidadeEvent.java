package org.leo.despesas.infra.eventos;

public class EntidadeEvent {

	private Long id;
	private String topic;
	private TipoEventoEntidade tipo;

	public EntidadeEvent(Long id, String topic, TipoEventoEntidade tipo) {
		super();
		this.id = id;
		this.topic = topic;
		this.tipo = tipo;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public TipoEventoEntidade getTipo() {
		return tipo;
	}

	public void setTipo(TipoEventoEntidade tipo) {
		this.tipo = tipo;
	}

}
