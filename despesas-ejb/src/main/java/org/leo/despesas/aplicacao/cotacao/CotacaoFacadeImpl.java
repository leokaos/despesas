package org.leo.despesas.aplicacao.cotacao;

import java.util.Date;

import javax.ejb.EJB;
import javax.ejb.Stateless;

import org.leo.despesas.aplicacao.parametro.ParametroFacade;
import org.leo.despesas.dominio.servicotransferencia.Cotacao;
import org.leo.despesas.dominio.servicotransferencia.CotacaoFiltro;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.Moeda;
import org.leo.despesas.infra.cotacao.CotacaoUrlParser;

@Stateless
public class CotacaoFacadeImpl extends AbstractFacade<Cotacao, CotacaoFiltro> implements CotacaoFacade {

	@EJB
	private ParametroFacade parametroFacade;

	@Override
	protected Class<Cotacao> getClasseEntidade() {
		return Cotacao.class;
	}

	@Override
	public Cotacao buscarCotacaoInternet(Moeda origem, Moeda destino) {

		String urlParaCotacao = parametroFacade.getUrlParaCotacao(origem, destino);

		Cotacao cotacao = new Cotacao();

		cotacao.setData(new Date());
		cotacao.setDestino(destino);
		cotacao.setOrigem(origem);
		cotacao.setTaxa(CotacaoUrlParser.getCotacao(urlParaCotacao));

		return cotacao;
	}
}
