package org.leo.despesas.dominio;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "conta", schema = "despesas_db")
public class Conta {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "nome")
	private String nome;

	@Column(name = "saldo")
	private BigDecimal saldo;

	@Column(name = "cor")
	private String cor;

	public Conta() {
		super();

		this.saldo = BigDecimal.ZERO;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public BigDecimal getSaldo() {
		return saldo;
	}

	public void setSaldo(BigDecimal saldo) {
		this.saldo = saldo;
	}

	public String getCor() {
		return cor;
	}

	public void setCor(String cor) {
		this.cor = cor;
	}

	public void pagar(Despesa despesa) {
		BigDecimal saldo = this.saldo.subtract(despesa.getValor());

		setSaldo(saldo);
	}

	public void depositar(Receita receita) {
		BigDecimal saldo = this.saldo.add(receita.getValor());

		setSaldo(saldo);
	}

}
