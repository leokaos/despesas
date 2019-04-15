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

import org.leo.despesas.rest.infra.ModelEntity;

@Entity
@Table(name = "tipo_movimentacao", schema = "despesas_db")
@DiscriminatorColumn(name = "tipo")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
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

	public TipoMovimentacao() {
		super();
	}

	@Override
	public Long getId() {
		return id;
	}

	public void setId(final Long id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(final String descricao) {
		this.descricao = descricao;
	}

	public String getCor() {
		return cor;
	}

	public void setCor(final String cor) {
		this.cor = cor;
	}

}
