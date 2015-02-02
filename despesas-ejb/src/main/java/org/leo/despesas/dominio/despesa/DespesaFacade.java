package org.leo.despesas.dominio.despesa;

import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.Despesa;
import org.leo.despesas.dominio.GraficoVO;
import org.leo.despesas.dominio.Periodo;
import org.leo.despesas.rest.infra.SimpleFacade;

@Local
public interface DespesaFacade extends SimpleFacade<Despesa> {

	List<GraficoVO> getGraficoPorPeriodo(Periodo periodo);

}
