package org.leo.despesas.aplicacao.investimento;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.Investimento;
import org.leo.despesas.dominio.debitavel.InvestimentoFiltro;
import org.leo.despesas.infra.SimpleFacade;

@Local
public interface InvestimentoFacade extends SimpleFacade<Investimento, InvestimentoFiltro> {

	void consolidar(Investimento investimento);


}
