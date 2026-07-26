package org.leo.despesas.aplicacao.notificacao;

import javax.ejb.Local;

import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.notificacao.NotificacaoFiltro;
import org.leo.despesas.infra.SimpleFacade;

@Local
public interface NotificacaoFacade extends SimpleFacade<Notificacao, NotificacaoFiltro> {

}
