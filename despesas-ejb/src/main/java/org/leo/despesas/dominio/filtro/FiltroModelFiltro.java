package org.leo.despesas.dominio.filtro;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class FiltroModelFiltro extends AbstractModelFiltro<Filtro> {

	@QueryParam("nome")
	private String nome;

	@QueryParam("classe")
	private String classe;

	@Override
	protected void build() {
		eqIgnoreCase("nome", nome);
		eq("classe", classe);
	}

}
