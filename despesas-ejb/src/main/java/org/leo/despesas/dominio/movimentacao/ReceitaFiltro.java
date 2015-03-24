package org.leo.despesas.dominio.movimentacao;

import java.util.Date;

import org.leo.despesas.dominio.tipomovimentacao.TipoReceita;

public class ReceitaFiltro {

    private Date dataInicial;
    private Date dataFinal;
    private TipoReceita tipoReceita;

    public ReceitaFiltro() {
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

    public TipoReceita getTipoReceita() {
	return tipoReceita;
    }

    public void setTipoReceita(TipoReceita tipoReceita) {
	this.tipoReceita = tipoReceita;
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

}
