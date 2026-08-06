package org.leo.despesas.aplicacao.grafico;

import java.time.LocalDate;

import javax.ejb.Local;

import org.leo.despesas.infra.grafico.GraficoLinha;

@Local
public interface GraficoFacade {

	GraficoLinha getGraficoDespesas(LocalDate dataInicial, LocalDate dataFinal);

	GraficoLinha getGraficoReceitas(LocalDate dataInicial, LocalDate dataFinal);

}
