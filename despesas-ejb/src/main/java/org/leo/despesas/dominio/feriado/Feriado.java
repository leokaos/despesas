package org.leo.despesas.dominio.feriado;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.leo.despesas.infra.ModelEntity;

@Entity
@Table(name = "feriado", schema = "despesas_db")
public class Feriado implements ModelEntity {

	private static final long serialVersionUID = 4169767769355199976L;

	@Id
	@GeneratedValue(generator = "FERIADO_ID_SEQ", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "FERIADO_ID_SEQ", sequenceName = "despesas_db.feriado_id_seq", allocationSize = 1)
	private Long id;

	@Column(name = "date_feriado")
	@Temporal(TemporalType.DATE)
	private Date data;

	@Enumerated(EnumType.STRING)
	private FeriadoTipo tipo;

	public Feriado() {
		super();
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public FeriadoTipo getTipo() {
		return tipo;
	}

	public void setTipo(FeriadoTipo tipo) {
		this.tipo = tipo;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Override
	public Long getId() {
		return this.id;
	}

}
