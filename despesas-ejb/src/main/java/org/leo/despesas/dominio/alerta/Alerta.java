package org.leo.despesas.dominio.alerta;

import java.util.Optional;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.infra.ModelEntity;

@Entity
@Table(name = "alerta", schema = "despesas_db")
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class Alerta implements ModelEntity {

	private static final long serialVersionUID = 3937060574469790488L;

	@Id
	@GeneratedValue(generator = "ALERTA_ID_SEQ", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "ALERTA_ID_SEQ", sequenceName = "despesas_db.alerta_id_seq", allocationSize = 1)
	private Long id;

	@Column(name = "tipo")
	@Enumerated(EnumType.STRING)
	private TipoAlerta tipo;

	public Alerta() {
		super();
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public TipoAlerta getTipo() {
		return tipo;
	}

	public void setTipo(TipoAlerta tipo) {
		this.tipo = tipo;
	}

	public abstract Optional<Notificacao> gerarNotificacao();

	public abstract String getDescricao();

}
