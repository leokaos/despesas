package org.leo.despesas.infra.grafico;

import java.util.List;

public class Serie {

	private final String nome;
	private final String cor;
	private final List<Ponto> pontos;

	public Serie(String nome,String cor,List<Ponto> pontos) {
		super();
		this.nome = nome;
		this.cor = cor;
		this.pontos = pontos;
	}

	public String getNome() {
		return nome;
	}

	public String getCor() {
		return cor;
	}

	public List<Ponto> getPontos() {
		return pontos;
	}

}
