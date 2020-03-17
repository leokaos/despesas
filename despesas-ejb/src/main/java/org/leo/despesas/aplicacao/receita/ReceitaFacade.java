package org.leo.despesas.aplicacao.receita;

import java.io.File;
import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.ReceitaFiltro;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.SimpleFacade;
import org.leo.despesas.rest.GraficoVO;

@Local
public interface ReceitaFacade extends SimpleFacade<Receita, ReceitaFiltro> {

	List<GraficoVO> getGraficoPorPeriodo(Periodo periodo);

	void depositar(Receita receita);

	List<Receita> carregarDeArquivo(File arquivoReceitas);

}
