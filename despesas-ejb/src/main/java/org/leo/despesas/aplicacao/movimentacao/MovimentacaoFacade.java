package org.leo.despesas.aplicacao.movimentacao;

import java.util.Date;
import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.movimentacao.Movimentacao;

@Local
public interface MovimentacaoFacade {

	List<Movimentacao> buscarMovimentacaoPorPeriodo(Date dataInicial,Date dataFinal);

}
