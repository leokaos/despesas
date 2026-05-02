package org.leo.despesas.aplicacao.feriado;

import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.feriado.Feriado;
import org.leo.despesas.dominio.feriado.FeriadoFiltro;
import org.leo.despesas.dominio.feriado.FeriadoTipo;
import org.leo.despesas.infra.SimpleFacade;
import org.leo.despesas.infra.exception.DespesasException;

@Local
public interface FeriadoFacade extends SimpleFacade<Feriado, FeriadoFiltro> {

	List<Feriado> getFeriadosPelaApi(Integer ano, FeriadoTipo tipo) throws DespesasException;

}
