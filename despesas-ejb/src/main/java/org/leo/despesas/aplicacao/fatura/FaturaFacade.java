package org.leo.despesas.aplicacao.fatura;

import java.util.Date;
import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.debitavel.FaturaFiltro;
import org.leo.despesas.infra.SimpleFacade;
import org.leo.despesas.infra.exception.DespesasException;

@Local
public interface FaturaFacade extends SimpleFacade<Fatura, FaturaFiltro> {

	List<Fatura> buscarFaturaPorCartaoCredito(CartaoCredito cartaoCredito);

	Fatura pagarFatura(Fatura fatura, Conta conta, Date dataPagamento) throws DespesasException;

}
