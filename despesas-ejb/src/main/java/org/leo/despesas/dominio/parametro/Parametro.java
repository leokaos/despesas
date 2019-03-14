package org.leo.despesas.dominio.parametro;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "parametros", schema = "despesas_db")
public class Parametro implements Serializable {

	private static final long serialVersionUID = 1080932091839453706L;

	@Id
	@Column(name = "NOME")
	private String nome;

	@Column(name = "TIPO")
	private String tipo;

	@Column(name = "VALOR")
	private String valor;

	public Parametro() {
		super();
	}

	public String getNome() {
		return this.nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getTipo() {
		return this.tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getValor() {
		return this.valor;
	}

	public void setValor(String valor) {
		this.valor = valor;
	}

}