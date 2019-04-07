package org.leo.despesas.aplicacao.orcamento;

import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.orcamento.Orcamento;
import org.leo.despesas.dominio.orcamento.OrcamentoFiltro;
import org.leo.despesas.rest.infra.SimpleFacade;

@Local
public interface OrcamentoFacade extends SimpleFacade<Orcamento, OrcamentoFiltro> {

	List<Orcamento> buscarPorFiltro(OrcamentoFiltro filtro);

	Orcamento consolidar(Orcamento orcamento);

}
