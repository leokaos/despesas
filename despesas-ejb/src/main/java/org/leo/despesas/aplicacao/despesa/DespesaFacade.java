package org.leo.despesas.aplicacao.despesa;

import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.GraficoVO;
import org.leo.despesas.dominio.debitavel.DespesaFiltro;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.SimpleFacade;

@Local
public interface DespesaFacade extends SimpleFacade<Despesa> {

	List<GraficoVO> getGraficoPorPeriodo(Periodo periodo);

	List<Despesa> getDespesasPorPeriodo(Periodo periodo);

	List<Despesa> buscarPorFiltro(DespesaFiltro filtro);

	void pagar(Despesa despesa);

}
