package org.leo.despesas.dominio.tipodespesa;

import javax.ejb.Local;

import org.leo.despesas.dominio.TipoDespesa;
import org.leo.despesas.rest.infra.SimpleFacade;

@Local
public interface TipoDespesaFacade extends SimpleFacade<TipoDespesa> {

}
