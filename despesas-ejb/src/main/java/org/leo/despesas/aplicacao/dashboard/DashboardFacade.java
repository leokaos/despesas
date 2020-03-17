package org.leo.despesas.aplicacao.dashboard;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.rest.GraficoVO;

@Local
public interface DashboardFacade {

	List<GraficoVO> getExtratoMes(Date dataInicial,Date dataFinal);

	BigDecimal getSaldoGeral(Date dataInicial,Date dataFinal);

}
