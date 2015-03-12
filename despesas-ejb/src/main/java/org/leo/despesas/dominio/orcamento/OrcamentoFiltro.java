package org.leo.despesas.dominio.orcamento;

import java.util.Date;

import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;

public class OrcamentoFiltro {

    private Date dataInicial;
    private Date dataFinal;
    private TipoDespesa tipoDespesa;

    public OrcamentoFiltro() {
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

    public TipoDespesa getTipoDespesa() {
	return tipoDespesa;
    }

    public void setTipoDespesa(TipoDespesa tipoDespesa) {
	this.tipoDespesa = tipoDespesa;
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
	return tipoDespesa != null;
    }

}
