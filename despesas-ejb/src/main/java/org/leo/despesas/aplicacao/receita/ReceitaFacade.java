package org.leo.despesas.aplicacao.receita;

import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.aplicacao.despesa.ContentUploadble;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.ReceitaFiltro;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.SimpleFacade;
import org.leo.despesas.rest.GraficoVO;

@Local
public interface ReceitaFacade extends SimpleFacade<Receita, ReceitaFiltro>, ContentUploadble<Receita> {

	List<GraficoVO> getGraficoPorPeriodo(Periodo periodo);

	void depositar(Receita receita);

}
