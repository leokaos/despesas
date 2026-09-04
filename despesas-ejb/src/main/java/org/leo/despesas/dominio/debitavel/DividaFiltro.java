package org.leo.despesas.dominio.debitavel;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class DividaFiltro extends BaseDebitavelFiltro<Divida> {

	private List<Periodicidade> periodicidades;

	@Override
	protected void internalBuild() {
		in("periodicidade", periodicidades);
	}

}
