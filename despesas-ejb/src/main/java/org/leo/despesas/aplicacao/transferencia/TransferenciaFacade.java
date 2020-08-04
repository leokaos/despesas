package org.leo.despesas.aplicacao.transferencia;

import java.util.Date;
import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.dominio.movimentacao.TransferenciaFiltro;
import org.leo.despesas.dominio.servicotransferencia.Cotacao;
import org.leo.despesas.dominio.servicotransferencia.ServicoTransferencia;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.SimpleFacade;
import org.leo.despesas.infra.exception.DespesasException;

@Local
public interface TransferenciaFacade extends SimpleFacade<Transferencia, TransferenciaFiltro> {

	void pagarFatura(Fatura fatura, Conta conta, Date dataPagamento) throws DespesasException;

	List<Transferencia> getTransferenciasPorPeriodo(Periodo periodo);

	Transferencia inserir(Transferencia transferencia, ServicoTransferencia servicoTransferencia, Cotacao cotacao) throws DespesasException;

}
