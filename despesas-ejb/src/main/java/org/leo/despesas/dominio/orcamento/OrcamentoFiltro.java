package org.leo.despesas.dominio.orcamento;

import java.time.LocalDate;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class OrcamentoFiltro extends AbstractModelFiltro<Orcamento> {

	@QueryParam("dataInicial")
	private LocalDate dataInicial;

	@QueryParam("dataFinal")
	private LocalDate dataFinal;

	@QueryParam("tipoDespesa")
	private String tipoDespesa;

	@Override
	protected void build() {

		greaterOrEqualThan("dataInicial", dataInicial);

		lessOrEqualThan("dataFinal", dataFinal);

		eq("tipoDespesa.descricao", tipoDespesa);

	}

}
