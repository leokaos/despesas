package org.leo.despesas.aplicacao.despesa;

import java.io.File;
import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.DespesaFiltro;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.SimpleFacade;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.rest.GraficoVO;
import org.leo.despesas.rest.ParcelamentoVO;

@Local
public interface DespesaFacade extends SimpleFacade<Despesa, DespesaFiltro> {

	List<GraficoVO> getGraficoPorPeriodo(Periodo periodo);

	void pagar(Despesa despesa);

	Despesa inserir(Despesa despesa,ParcelamentoVO parcelamentoVO) throws DespesasException;

	List<Despesa> carregarDeArquivo(File arquivoDespesas);

}
