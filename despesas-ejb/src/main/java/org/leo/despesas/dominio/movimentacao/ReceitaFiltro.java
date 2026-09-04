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
public class ReceitaFiltro extends AbstractModelFiltro<Receita> {

	@QueryParam("dataInicial")
	private LocalDate dataInicial;

	@QueryParam("dataFinal")
	private LocalDate dataFinal;

	@QueryParam("tipoReceita")
	private String tipoReceita;

	@QueryParam("moeda")
	private Moeda moeda;

	@QueryParam("debitavel_id")
	private Long debitavelId;

	private Debitavel debitavel;

	@QueryParam("compromissada")
	private Boolean compromissada;

	@Override
	protected void build() {

		between("vencimento", dataInicial, dataFinal);

		eq("tipo.descricao", tipoReceita);

		eq("debitavel", debitavel);

		eq("moeda", moeda);

		eq("debitavel.id", debitavelId);

		eq("compromissada", compromissada);

	}

	@Override
	protected String orderBy() {
		return "vencimento DESC";
	}

}
