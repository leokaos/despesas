package org.leo.despesas.aplicacao.feriado;

import javax.ejb.Local;

import org.leo.despesas.dominio.feriado.Feriado;
import org.leo.despesas.dominio.feriado.FeriadoFiltro;
import org.leo.despesas.infra.SimpleFacade;

@Local
public interface FeriadoFacade extends SimpleFacade<Feriado, FeriadoFiltro> {

}
