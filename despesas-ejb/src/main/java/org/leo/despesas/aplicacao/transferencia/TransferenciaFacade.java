package org.leo.despesas.aplicacao.transferencia;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.rest.infra.SimpleFacade;

@Local
public interface TransferenciaFacade extends SimpleFacade<Transferencia> {

	void pagarFatura(Fatura fatura,Conta conta);

}
