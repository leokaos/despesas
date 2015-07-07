package org.leo.despesas.aplicacao.grafico;

import java.util.Date;

import javax.ejb.Local;

import org.leo.despesas.dominio.movimentacao.WrapperGraficoVO;

@Local
public interface GraficoFacade {

	WrapperGraficoVO getGraficoDespesas(Date dataInicial, Date dataFinal);

	WrapperGraficoVO getGraficoReceitas(Date dataInicial, Date dataFinal);

	WrapperGraficoVO getExtrato(Date dataInicial, Date dataFinal);

}
