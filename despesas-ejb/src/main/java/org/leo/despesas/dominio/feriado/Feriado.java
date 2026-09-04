package org.leo.despesas.dominio.feriado;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.leo.despesas.infra.ModelEntity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "feriado", schema = "despesas_db")
@Getter
@Setter
@NoArgsConstructor
public class Feriado implements ModelEntity {

	private static final long serialVersionUID = 4169767769355199976L;

	@Id
	@GeneratedValue(generator = "FERIADO_ID_SEQ", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "FERIADO_ID_SEQ", sequenceName = "despesas_db.feriado_id_seq", allocationSize = 1)
	private Long id;

	@Column(name = "date_feriado")
	private LocalDate data;

	@Enumerated(EnumType.STRING)
	private FeriadoTipo tipo;

	@Column(name = "nome")
	private String nome;

}
