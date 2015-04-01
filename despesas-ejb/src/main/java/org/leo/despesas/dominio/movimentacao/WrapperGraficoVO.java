package org.leo.despesas.dominio.movimentacao;

import java.util.List;

public class WrapperGraficoVO {

	private final String titulo;
	private final List<GraficoVO> dados;

	public WrapperGraficoVO(String titulo, List<GraficoVO> dados) {
		super();
		this.titulo = titulo;
		this.dados = dados;
	}

	public String getTitulo() {
		return titulo;
	}

	public List<GraficoVO> getDados() {
		return dados;
	}

}
