package org.leo.despesas.dominio.movimentacao;

import java.util.Date;

import javax.ws.rs.QueryParam;

import org.apache.commons.lang3.StringUtils;
import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.infra.AbstractModelFiltro;
import org.leo.despesas.infra.Moeda;

public class DespesaFiltro extends AbstractModelFiltro<Despesa> {

	@QueryParam("dataInicial")
	private Date dataInicial;

	@QueryParam("dataFinal")
	private Date dataFinal;

	@QueryParam("tipoDespesa")
	private String tipoDespesa;

	@QueryParam("moeda")
	private Moeda moeda;

	@QueryParam("debitavel_id")
	private Long debitavelId;

	private Debitavel debitavel;

	public DespesaFiltro() {
		super();
	}

	public Date getDataInicial() {
		return dataInicial;
	}

	public void setDataInicial(Date dataInicial) {
		this.dataInicial = dataInicial;
	}

	public Date getDataFinal() {
		return dataFinal;
	}

	public void setDataFinal(Date dataFinal) {
		this.dataFinal = dataFinal;
	}

	public String getTipoDespesa() {
		return tipoDespesa;
	}

	public void setTipoDespesa(String tipoDespesa) {
		this.tipoDespesa = tipoDespesa;
	}

	public Moeda getMoeda() {
		return moeda;
	}

	public void setMoeda(Moeda moeda) {
		this.moeda = moeda;
	}

	public Debitavel getDebitavel() {
		return debitavel;
	}

	public void setDebitavel(Debitavel debitavel) {
		this.debitavel = debitavel;
	}

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

}
