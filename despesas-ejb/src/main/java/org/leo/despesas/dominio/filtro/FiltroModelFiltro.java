package org.leo.despesas.dominio.filtro;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;

public class FiltroModelFiltro extends AbstractModelFiltro<Filtro> {

	@QueryParam("nome")
	private String nome;

	@QueryParam("classe")
	private String classe;

	public FiltroModelFiltro() {
		super();
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getClasse() {
		return classe;
	}

	public void setClasse(String classe) {
		this.classe = classe;
	}

	@Override
	protected void build() {

		eqIgnoreCase("nome", nome);

		eq("classe", classe);
	}

}
