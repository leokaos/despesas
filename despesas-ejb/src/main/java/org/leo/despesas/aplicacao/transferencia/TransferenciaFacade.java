package org.leo.despesas.aplicacao.transferencia;

import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.dominio.movimentacao.TransferenciaFiltro;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.rest.infra.SimpleFacade;

@Local
public interface TransferenciaFacade extends SimpleFacade<Transferencia> {

	void pagarFatura(Fatura fatura, Conta conta) throws DespesasException;

	List<Transferencia> getTransferenciasPorPeriodo(Periodo periodo);

	List<Transferencia> buscarPorFiltro(TransferenciaFiltro filtro);

}
