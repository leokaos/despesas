package org.leo.despesas.aplicacao.filtro;

import javax.ejb.Local;

import org.leo.despesas.dominio.filtro.Filtro;
import org.leo.despesas.dominio.filtro.FiltroModelFiltro;
import org.leo.despesas.infra.SimpleFacade;

@Local
public interface FiltroFacade extends SimpleFacade<Filtro, FiltroModelFiltro> {

}
