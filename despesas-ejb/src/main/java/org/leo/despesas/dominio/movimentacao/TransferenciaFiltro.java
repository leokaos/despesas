package org.leo.despesas.dominio.movimentacao;

import java.util.Date;

import javax.ws.rs.QueryParam;

import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.infra.AbstractModelFiltro;

public class TransferenciaFiltro extends AbstractModelFiltro<Transferencia> {

	@QueryParam("dataInicial")
	private Date dataInicial;

	@QueryParam("dataFinal")
	private Date dataFinal;

	private Debitavel debitavel;

	private Debitavel creditavel;

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

	public boolean hasDataInicialAndDataFinal() {
		return dataInicial != null && dataFinal != null;
	}

	public boolean hasDataInicial() {
		return dataInicial != null;
	}

	public boolean hasDataFinal() {
		return dataFinal != null;
	}

	public Debitavel getDebitavel() {
		return debitavel;
	}

	public void setDebitavel(Debitavel debitavel) {
		this.debitavel = debitavel;
	}

	public Debitavel getCreditavel() {
		return creditavel;
	}

	public void setCreditavel(Debitavel creditavel) {
		this.creditavel = creditavel;
	}

	@Override
	protected void build() {

		between("vencimento", dataInicial, dataFinal);

		eq("debitavel", debitavel);

		eq("creditavel", creditavel);
	}

}
