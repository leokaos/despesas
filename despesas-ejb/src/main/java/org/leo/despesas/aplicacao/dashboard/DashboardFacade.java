package org.leo.despesas.aplicacao.dashboard;

import java.util.Date;
import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.movimentacao.GraficoVO;

@Local
public interface DashboardFacade {

	List<GraficoVO> getExtratoMes(Date dataInicial, Date dataFinal);

}
