package org.leo.despesas.rest;

import java.util.List;

import org.leo.despesas.dominio.movimentacao.TipoGrafico;

public class WrapperGraficoVO {

	private final String titulo;
	private final TipoGrafico tipoGrafico;
	private final List<GraficoVO> dados;

	public WrapperGraficoVO(String titulo, TipoGrafico tipoGrafico, List<GraficoVO> dados) {
		super();
		this.titulo = titulo;
		this.tipoGrafico = tipoGrafico;
		this.dados = dados;
	}

	public TipoGrafico getTipoGrafico() {
		return tipoGrafico;
	}

	public String getTitulo() {
		return titulo;
	}

	public List<GraficoVO> getDados() {
		return dados;
	}

}
