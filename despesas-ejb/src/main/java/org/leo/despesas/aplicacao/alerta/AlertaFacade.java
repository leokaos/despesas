package org.leo.despesas.aplicacao.alerta;

import javax.ejb.Local;

import org.leo.despesas.dominio.alerta.Alerta;
import org.leo.despesas.dominio.alerta.AlertaFiltro;
import org.leo.despesas.infra.SimpleFacade;

@Local
public interface AlertaFacade extends SimpleFacade<Alerta, AlertaFiltro> {

}
