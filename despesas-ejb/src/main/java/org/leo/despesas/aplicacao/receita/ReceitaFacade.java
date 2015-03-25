package org.leo.despesas.aplicacao.receita;

import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.movimentacao.GraficoVO;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.ReceitaFiltro;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.rest.infra.SimpleFacade;

@Local
public interface ReceitaFacade extends SimpleFacade<Receita> {

    List<GraficoVO> getGraficoPorPeriodo(Periodo periodo);

    List<Receita> getReceitasPorPeriodo(Periodo periodo);

    List<Receita> buscarPorFiltro(ReceitaFiltro filtro);

    void depositar(Receita receita);

}