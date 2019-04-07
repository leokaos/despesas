package org.leo.despesas.aplicacao.tipodespesa;

import javax.ejb.Local;

import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesaFiltro;
import org.leo.despesas.rest.infra.SimpleFacade;

@Local
public interface TipoDespesaFacade extends SimpleFacade<TipoDespesa, TipoDespesaFiltro> {

}
