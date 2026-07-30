package org.leo.despesas.dominio.notificacao;

import java.time.LocalDate;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.leo.despesas.dominio.alerta.Alerta;
import org.leo.despesas.infra.Mes;
import org.leo.despesas.infra.ModelEntity;

@Entity
@Table(name = "notificacao", schema = "despesas_db")
public class Notificacao implements ModelEntity {

	private static final long serialVersionUID = 3641699997412117252L;

	@Id
	@GeneratedValue(generator = "NOTIFICACAO_ID_SEQ", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "NOTIFICACAO_ID_SEQ", sequenceName = "despesas_db.notificacao_id_seq", allocationSize = 1)
	private Long id;

	@Column(name = "executado")
	private boolean executado;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "origem_alerta_id", nullable = true)
	private Alerta alerta;

	@Column(name = "target_date")
	private LocalDate targetDate;

	@Embedded
	private Mes mes;

	public Notificacao() {
		super();
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public boolean isExecutado() {
		return executado;
	}

	public void setExecutado(boolean executado) {
		this.executado = executado;
	}

	public Alerta getAlerta() {
		return alerta;
	}

	public void setAlerta(Alerta alerta) {
		this.alerta = alerta;
	}

	public LocalDate getTargetDate() {
		return targetDate;
	}

	public void setTargetDate(LocalDate targetDate) {
		this.targetDate = targetDate;
	}

	public Mes getMes() {
		return mes;
	}

	public void setMes(Mes mes) {
		this.mes = mes;
	}

}
