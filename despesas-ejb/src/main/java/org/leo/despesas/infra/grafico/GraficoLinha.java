package org.leo.despesas.infra.grafico;

import java.util.List;

public class GraficoLinha {

	private final String nome;
	private final List<Serie> series;

	public GraficoLinha(String nome,List<Serie> series) {
		super();
		this.nome = nome;
		this.series = series;
	}

	public String getNome() {
		return nome;
	}

	public List<Serie> getSeries() {
		return series;
	}

}
