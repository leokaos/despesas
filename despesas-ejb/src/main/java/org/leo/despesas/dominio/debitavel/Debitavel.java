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

@Entity
@DiscriminatorColumn(name = "tipo")
@Table(name = "debitavel", schema = "despesas_db")
@Inheritance(strategy = InheritanceType.JOINED)
public class Debitavel {

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

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getCor() {
		return cor;
	}

	public void setCor(String cor) {
		this.cor = cor;
	}

	public void debitar(Despesa despesa) {

	};

	public void creditar(Receita receita) {

	}

	public Debitavel toDebitavel() {
		Debitavel debitavel = new Debitavel();

		debitavel.setCor(cor);
		debitavel.setDescricao(descricao);
		debitavel.setId(id);

		return debitavel;
	}

}
