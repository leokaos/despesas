package org.leo.despesas.aplicacao.projecao;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.projecao.Projecao;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.exception.DespesasException;

@Local
public interface ProjecaoFacade {

	Projecao criarProjecao(Debitavel debitavel, Periodo periodo) throws DespesasException;

}
