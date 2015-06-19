package org.leo.despesas.dominio.debitavel;

import java.math.BigDecimal;

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

@Entity
@DiscriminatorColumn(name = "tipo")
@Table(name = "debitavel", schema = "despesas_db")
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class Debitavel {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "descricao")
	private String descricao;

	@Column(name = "cor")
	private String cor;

	@Column(name = "tipo", insertable = false, updatable = false)
	private String tipo;

	public Debitavel(final String tipo) {
		super();
		this.tipo = tipo;
	}

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

	public String getTipo() {
		return tipo;
	}

	public void setTipo(final String tipo) {
		this.tipo = tipo;
	}

	public void transferir(final Debitavel saida, final BigDecimal valor) {
		saida.debitarValor(valor);
		this.creditarValor(valor);
	}

	protected abstract void debitarValor(BigDecimal valor);

	protected abstract void creditarValor(BigDecimal valor);

	public abstract void debitar(Despesa despesa);

	public abstract void creditar(Receita receita);

	public abstract Despesa consolidar(Despesa despesa);

}
