package org.leo.despesas.dominio.movimentacao;

import java.time.LocalDate;

import javax.ws.rs.QueryParam;

import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.infra.AbstractModelFiltro;
import org.leo.despesas.infra.Moeda;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TransferenciaFiltro extends AbstractModelFiltro<Transferencia> {

	@QueryParam("dataInicial")
	private LocalDate dataInicial;

	@QueryParam("dataFinal")
	private LocalDate dataFinal;

	private Debitavel debitavel;

	private Debitavel creditavel;

	private Moeda moeda;

	@Override
	protected void build() {

		between("vencimento", dataInicial, dataFinal);

		eq("debitavel", debitavel);

		eq("creditavel", creditavel);

		eq("moeda", moeda);
	}

}
