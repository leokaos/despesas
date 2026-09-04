package org.leo.despesas.dominio.filtro;

import javax.persistence.Column;
import javax.persistence.Entity;
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
@Table(name = "filtro", schema = "despesas_db")
@Getter
@Setter
@NoArgsConstructor
public class Filtro implements ModelEntity {

	private static final long serialVersionUID = -4520402971910298724L;

	@Id
	@GeneratedValue(generator = "FILTRO_ID_SEQ", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "FILTRO_ID_SEQ", sequenceName = "despesas_db.filtro_id_seq", allocationSize = 1)
	private Long id;

	@Column(name = "nome")
	private String nome;

	@Column(name = "expressao")
	private String expressao;

	@Column(name = "classe")
	private String classe;

}
