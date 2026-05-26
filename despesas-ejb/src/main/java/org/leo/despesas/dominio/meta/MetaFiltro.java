package org.leo.despesas.dominio.meta;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;
import org.leo.despesas.infra.Mes;

public class MetaFiltro extends AbstractModelFiltro<Meta> {

	@QueryParam("ano")
	private Integer ano;

	@QueryParam("mes")
	private Integer mes;

	public MetaFiltro() {
		super();
	}

	public Integer getAno() {
		return ano;
	}

	public void setAno(Integer ano) {
		this.ano = ano;
	}

	public Integer getMes() {
		return mes;
	}

	public void setMes(Integer mes) {
		this.mes = mes;
	}

	@Override
	protected void build() {

		if (ano != null && mes != null) {
			eq("mes", new Mes(mes, ano));
		}

	}

}
