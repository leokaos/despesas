package org.leo.despesas.dominio.debitavel;

import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.rest.infra.ModelEntity;

@Entity
@DiscriminatorColumn(name = "tipo")
@Table(name = "debitavel", schema = "despesas_db")
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class Debitavel implements ModelEntity {

	private static final long serialVersionUID = -2096306756580686432L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "descricao")
	private String descricao;

	@Column(name = "cor")
	private String cor;

	public Debitavel() {
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

	public abstract void debitar(Despesa despesa);

	public abstract void creditar(Receita receita);

	public abstract void transferir(Transferencia transferencia);

	public abstract Despesa consolidar(Despesa despesa);

}
