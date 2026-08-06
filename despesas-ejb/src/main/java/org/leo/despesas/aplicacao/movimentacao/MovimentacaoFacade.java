package org.leo.despesas.aplicacao.movimentacao;

import java.time.LocalDate;
import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.movimentacao.Movimentacao;

@Local
public interface MovimentacaoFacade {

	List<Movimentacao> buscarMovimentacaoPorPeriodo(LocalDate dataInicial, LocalDate dataFinal);

	long buscarQuantidadeMovimentacaoPorDebitavel(Debitavel debitavel);

}
