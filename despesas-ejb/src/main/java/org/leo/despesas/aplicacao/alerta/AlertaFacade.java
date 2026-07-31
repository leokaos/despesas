package org.leo.despesas.aplicacao.alerta;

import javax.ejb.Local;

import org.leo.despesas.dominio.alerta.Alerta;
import org.leo.despesas.dominio.alerta.AlertaFiltro;
import org.leo.despesas.infra.SimpleFacade;
import org.leo.despesas.infra.exception.DespesasException;

@Local
public interface AlertaFacade extends SimpleFacade<Alerta, AlertaFiltro> {

	void gerarNotificacoes() throws DespesasException;

}
