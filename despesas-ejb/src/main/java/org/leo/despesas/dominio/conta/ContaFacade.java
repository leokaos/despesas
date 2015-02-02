package org.leo.despesas.dominio.conta;

import javax.ejb.Local;

import org.leo.despesas.dominio.Conta;
import org.leo.despesas.rest.infra.SimpleFacade;

@Local
public interface ContaFacade extends SimpleFacade<Conta> {

}
