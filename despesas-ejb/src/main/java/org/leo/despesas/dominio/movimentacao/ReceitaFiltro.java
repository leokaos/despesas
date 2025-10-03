package org.leo.despesas.dominio.movimentacao;

import java.util.Date;

import javax.ws.rs.QueryParam;

import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.infra.AbstractModelFiltro;
import org.leo.despesas.infra.Moeda;

public class ReceitaFiltro extends AbstractModelFiltro<Receita> {

	@QueryParam("dataInicial")
	private Date dataInicial;

	@QueryParam("dataFinal")
	private Date dataFinal;

	@QueryParam("tipoReceita")
	private String tipoReceita;

	@QueryParam("moeda")
	private Moeda moeda;

	private Debitavel debitavel;

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

	public String getTipoReceita() {
		return tipoReceita;
	}

	public Debitavel getDebitavel() {
		return debitavel;
	}

	public void setDebitavel(Debitavel debitavel) {
		this.debitavel = debitavel;
	}

	public void setTipoReceita(String tipoReceita) {
		this.tipoReceita = tipoReceita;
	}

	public Moeda getMoeda() {
		return moeda;
	}

	public void setMoeda(Moeda moeda) {
		this.moeda = moeda;
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

	public boolean hasTipoReceita() {
		return tipoReceita != null;
	}

	@Override
	protected void build() {

		between("vencimento", dataInicial, dataFinal);

		eq("tipo.descricao", tipoReceita);

		eq("debitavel", debitavel);

		eq("moeda", moeda);

	}

}
