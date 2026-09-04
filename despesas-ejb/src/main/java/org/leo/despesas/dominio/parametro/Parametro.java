package org.leo.despesas.dominio.parametro;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "parametros", schema = "despesas_db")
@Getter
@Setter
@NoArgsConstructor
public class Parametro implements Serializable {

	private static final long serialVersionUID = 1080932091839453706L;

	@Id
	@Column(name = "NOME")
	private String nome;

	@Column(name = "TIPO")
	private String tipo;

	@Column(name = "VALOR")
	private String valor;

}