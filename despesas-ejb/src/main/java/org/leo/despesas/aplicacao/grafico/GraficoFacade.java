package org.leo.despesas.aplicacao.grafico;

import java.util.Date;

import javax.ejb.Local;

import org.leo.despesas.infra.grafico.GraficoLinha;

@Local
public interface GraficoFacade {

	GraficoLinha getGraficoDespesas(Date dataInicial,Date dataFinal);

}
