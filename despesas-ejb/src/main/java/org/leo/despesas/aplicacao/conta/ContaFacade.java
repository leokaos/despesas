package org.leo.despesas.aplicacao.conta;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.ContaFiltro;
import org.leo.despesas.infra.SimpleFacade;

@Local
public interface ContaFacade extends SimpleFacade<Conta, ContaFiltro> {

}
