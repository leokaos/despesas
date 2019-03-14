package org.leo.despesas.aplicacao.cotacao;

import javax.ejb.Local;

import org.leo.despesas.dominio.servicotransferencia.Cotacao;
import org.leo.despesas.dominio.servicotransferencia.Moeda;
import org.leo.despesas.rest.infra.SimpleFacade;

@Local
public interface CotacaoFacade extends SimpleFacade<Cotacao> {

	Cotacao buscarCotacaoInternet(Moeda origem, Moeda destino);

}
