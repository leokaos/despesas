package org.leo.despesas.dominio.alerta;

import java.util.Optional;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.leo.despesas.dominio.notificacao.Notificacao;

@Entity
@Table(name = "alerta_despesa_recorrente", schema = "despesas_db")
public class AlertaDespesaRecorrente extends Alerta {

	private static final long serialVersionUID = -5282519238519370892L;

	@Column(name = "titulo")
	private String titulo;

	public AlertaDespesaRecorrente() {
		super();
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	@Override
	public Optional<Notificacao> gerarNotificacao() {
		return Optional.empty();
	}

	@Override
	public String getDescricao() {
		return titulo;
	}

}
