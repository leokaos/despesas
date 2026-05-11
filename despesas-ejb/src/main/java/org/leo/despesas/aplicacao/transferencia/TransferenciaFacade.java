package org.leo.despesas.aplicacao.transferencia;

import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.dominio.movimentacao.TransferenciaFiltro;
import org.leo.despesas.dominio.servicotransferencia.Cotacao;
import org.leo.despesas.dominio.servicotransferencia.ServicoTransferencia;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.SimpleFacade;
import org.leo.despesas.infra.exception.DespesasException;

@Local
public interface TransferenciaFacade extends SimpleFacade<Transferencia, TransferenciaFiltro> {

	List<Transferencia> getTransferenciasPorPeriodo(Periodo periodo);

	Transferencia inserir(Transferencia transferencia, ServicoTransferencia servicoTransferencia, Cotacao cotacao) throws DespesasException;

}
