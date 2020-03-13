package org.leo.despesas.dominio.movimentacao;

import java.util.Date;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;

public class TransferenciaFiltro extends AbstractModelFiltro<Transferencia> {

	@QueryParam("dataInicial")
	private Date dataInicial;

	@QueryParam("dataFinal")
	private Date dataFinal;

	@QueryParam("tipoCreditavel")
	private String tipoCreditavel;

	public TransferenciaFiltro() {
		super();
	}

	public Date getDataInicial() {
		return dataInicial;
	}

	public void setDataInicial(final Date dataInicial) {
		this.dataInicial = dataInicial;
	}

	public Date getDataFinal() {
		return dataFinal;
	}

	public void setDataFinal(final Date dataFinal) {
		this.dataFinal = dataFinal;
	}

	public String getTipoCreditavel() {
		return tipoCreditavel;
	}

	public void setTipoCreditavel(String tipoCreditavel) {
		this.tipoCreditavel = tipoCreditavel;
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

	@Override
	protected void build() {

		between("vencimento", dataInicial, dataFinal);

		notEqual("creditavel.tipo", tipoCreditavel);
	}

}
