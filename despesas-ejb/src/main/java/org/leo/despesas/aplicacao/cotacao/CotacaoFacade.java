package org.leo.despesas.aplicacao.cotacao;

import javax.ejb.Local;

import org.leo.despesas.dominio.servicotransferencia.Cotacao;
import org.leo.despesas.dominio.servicotransferencia.CotacaoFiltro;
import org.leo.despesas.infra.Moeda;
import org.leo.despesas.infra.SimpleFacade;

@Local
public interface CotacaoFacade extends SimpleFacade<Cotacao, CotacaoFiltro> {

	Cotacao buscarCotacaoInternet(Moeda origem, Moeda destino);

}
