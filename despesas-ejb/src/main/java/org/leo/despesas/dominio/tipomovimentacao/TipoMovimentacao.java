package org.leo.despesas.dominio.tipomovimentacao;

import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.leo.despesas.infra.ModelEntity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "tipo_movimentacao", schema = "despesas_db")
@DiscriminatorColumn(name = "tipo")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@Setter
@Getter
@NoArgsConstructor
public class TipoMovimentacao implements ModelEntity {

	private static final long serialVersionUID = 6836888332543689391L;

	@Id
	@GeneratedValue(generator = "TIPO_MOVIMENTACAO_SEQ", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "TIPO_MOVIMENTACAO_SEQ", sequenceName = "despesas_db.tipo_movimentacao_id_seq", allocationSize = 1)
	@Column(name = "ID")
	private Long id;

	@Column(name = "descricao")
	private String descricao;

	@Column(name = "cor")
	private String cor;

}
