package org.leo.despesas.aplicacao.ativo;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.Ativo;
import org.leo.despesas.dominio.debitavel.AtivoFiltro;
import org.leo.despesas.infra.SimpleFacade;

@Local
public interface AtivoFacade extends SimpleFacade<Ativo, AtivoFiltro> {

}
