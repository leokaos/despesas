package org.leo.despesas.aplicacao.divida;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.Divida;
import org.leo.despesas.dominio.debitavel.DividaFiltro;
import org.leo.despesas.infra.SimpleFacade;

@Local
public interface DividaFacade extends SimpleFacade<Divida, DividaFiltro> {

}
