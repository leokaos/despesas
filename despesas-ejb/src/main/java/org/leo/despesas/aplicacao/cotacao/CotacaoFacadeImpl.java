package org.leo.despesas.aplicacao.cotacao;

import java.util.Date;

import javax.ejb.Stateless;
import javax.inject.Inject;

import org.leo.despesas.dominio.servicotransferencia.Cotacao;
import org.leo.despesas.dominio.servicotransferencia.CotacaoFiltro;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.Moeda;
import org.leo.despesas.infra.cotacao.CotacaoRepositorio;

@Stateless
public class CotacaoFacadeImpl extends AbstractFacade<Cotacao, CotacaoFiltro> implements CotacaoFacade {

	@Inject
	private CotacaoRepositorio cotacaoRepositorio;

	@Override
	protected Class<Cotacao> getClasseEntidade() {
		return Cotacao.class;
	}

	@Override
	public Cotacao buscarCotacaoInternet(Moeda origem, Moeda destino) {

		Cotacao cotacao = new Cotacao();

		cotacao.setData(new Date());
		cotacao.setDestino(destino);
		cotacao.setOrigem(origem);
		cotacao.setTaxa(cotacaoRepositorio.getCotacao(origem, destino));

		return cotacao;
	}
}
