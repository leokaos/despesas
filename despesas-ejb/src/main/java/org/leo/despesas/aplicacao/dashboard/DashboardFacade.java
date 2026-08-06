package org.leo.despesas.aplicacao.dashboard;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.rest.GraficoVO;

@Local
public interface DashboardFacade {

	List<GraficoVO> getExtratoMes(LocalDate dataInicial, LocalDate dataFinal);

	BigDecimal getSaldoGeral(LocalDate dataInicial, LocalDate dataFinal);

}
