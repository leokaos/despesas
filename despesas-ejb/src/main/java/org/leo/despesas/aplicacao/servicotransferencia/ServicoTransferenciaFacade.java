package org.leo.despesas.aplicacao.servicotransferencia;

import javax.ejb.Local;

import org.leo.despesas.dominio.servicotransferencia.ServicoTransferencia;
import org.leo.despesas.dominio.servicotransferencia.ServicoTransferenciaFiltro;
import org.leo.despesas.infra.SimpleFacade;

@Local
public interface ServicoTransferenciaFacade extends SimpleFacade<ServicoTransferencia, ServicoTransferenciaFiltro> {

}
