package org.leo.despesas.dominio.movimentacao;

import java.time.LocalDate;

import javax.ws.rs.QueryParam;

import org.apache.commons.lang3.StringUtils;
import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.infra.AbstractModelFiltro;
import org.leo.despesas.infra.Moeda;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class DespesaFiltro extends AbstractModelFiltro<Despesa> {

	@QueryParam("dataInicial")
	private LocalDate dataInicial;

	@QueryParam("dataFinal")
	private LocalDate dataFinal;

	@QueryParam("tipoDespesa")
	private String tipoDespesa;

	@QueryParam("moeda")
	private Moeda moeda;

	@QueryParam("debitavel_id")
	private Long debitavelId;

	private Debitavel debitavel;

	public boolean hasDataInicialAndDataFinal() {
		return dataInicial != null && dataFinal != null;
	}

	public boolean hasDataInicial() {
		return dataInicial != null;
	}

	public boolean hasDataFinal() {
		return dataFinal != null;
	}

	public boolean hasTipoDespesa() {
		return StringUtils.isNotEmpty(tipoDespesa);
	}

	@Override
	protected void build() {

		between("vencimento", dataInicial, dataFinal);

		eq("tipo.descricao", tipoDespesa);

		eq("debitavel", debitavel);

		eq("moeda", moeda);

		eq("debitavel.id", debitavelId);
	}

	@Override
	protected String orderBy() {
		return "vencimento DESC";
	}

}
