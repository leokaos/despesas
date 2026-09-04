package org.leo.despesas.dominio.servicotransferencia;

import java.time.LocalDate;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;
import org.leo.despesas.infra.Moeda;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class CotacaoFiltro extends AbstractModelFiltro<Cotacao> {

	@QueryParam("origem")
	private Moeda origem;

	@QueryParam("destino")
	private Moeda destino;

	@QueryParam("data")
	private LocalDate data;

	@Override
	protected void build() {
		eq("destino", destino);
		eq("origem", origem);
		eq("data", data);
	}
}
