package org.leo.despesas.aplicacao.tiporeceita;

import javax.ejb.Local;

import org.leo.despesas.dominio.tipomovimentacao.TipoReceita;
import org.leo.despesas.dominio.tipomovimentacao.TipoReceitaFiltro;
import org.leo.despesas.rest.infra.SimpleFacade;

@Local
public interface TipoReceitaFacade extends SimpleFacade<TipoReceita, TipoReceitaFiltro> {

}
