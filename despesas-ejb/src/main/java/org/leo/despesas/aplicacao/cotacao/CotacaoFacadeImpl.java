package org.leo.despesas.aplicacao.cotacao;

import java.util.Calendar;
import java.util.Date;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.TypedQuery;

import org.apache.commons.lang3.time.DateUtils;
import org.leo.despesas.dominio.servicotransferencia.Cotacao;
import org.leo.despesas.dominio.servicotransferencia.CotacaoFiltro;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.Moeda;
import org.leo.despesas.infra.cotacao.CotacaoRepositorio;
import org.leo.despesas.infra.exception.AlreadyExistentEntityException;
import org.leo.despesas.infra.exception.DespesasException;

@Stateless
public class CotacaoFacadeImpl extends AbstractFacade<Cotacao, CotacaoFiltro> implements CotacaoFacade {

	@Inject
	private CotacaoRepositorio cotacaoRepositorio;

	@Override
	protected Class<Cotacao> getClasseEntidade() {
		return Cotacao.class;
	}

	@Override
	protected void preInserir(Cotacao cotacao) throws DespesasException {
		super.preInserir(cotacao);

		String sql = "SELECT c FROM Cotacao c WHERE c.data BETWEEN :data_inicial AND :data_final AND c.origem = :origem AND c.destino = :destino";

		TypedQuery<Cotacao> query = entityManager.createQuery(sql, getClasseEntidade());

		Date inicio = DateUtils.truncate(cotacao.getData(), Calendar.DAY_OF_MONTH);
		Date fim = DateUtils.addSeconds(DateUtils.truncate(DateUtils.addDays(cotacao.getData(), 1), Calendar.DAY_OF_MONTH), -1);

		query.setParameter("data_inicial", inicio);
		query.setParameter("data_final", fim);
		query.setParameter("origem", cotacao.getOrigem());
		query.setParameter("destino", cotacao.getDestino());

		if (!query.getResultList().isEmpty()) {
			throw new AlreadyExistentEntityException("Cotação já existe para essas moedas e data!");
		}
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
