package org.leo.despesas.aplicacao.orcamento;

import javax.ejb.Local;

import org.leo.despesas.dominio.orcamento.Orcamento;
import org.leo.despesas.dominio.orcamento.OrcamentoFiltro;
import org.leo.despesas.infra.SimpleFacade;

@Local
public interface OrcamentoFacade extends SimpleFacade<Orcamento, OrcamentoFiltro> {

	Orcamento consolidar(Orcamento orcamento);

}
