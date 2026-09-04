package org.leo.despesas.dominio.feriado;

import java.time.LocalDate;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class FeriadoFiltro extends AbstractModelFiltro<Feriado> {

	@QueryParam("dataInicial")
	private LocalDate dataInicial;

	@QueryParam("dataFinal")
	private LocalDate dataFinal;

	@Override
	protected void build() {
		between("data", dataInicial, dataFinal);
	}

}
