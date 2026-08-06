package org.leo.despesas.aplicacao.cotacao;

import java.time.LocalDate;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.TypedQuery;

import org.leo.despesas.dominio.servicotransferencia.Cotacao;
import org.leo.despesas.dominio.servicotransferencia.CotacaoFiltro;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.Moeda;
import org.leo.despesas.infra.cotacao.CotacaoRepositorio;
import org.leo.despesas.infra.exception.AlreadyExistentEntityException;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.infra.util.DataUtil;

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

		String sql = "SELECT c FROM Cotacao c WHERE c.data = :data AND c.origem = :origem AND c.destino = :destino";

		TypedQuery<Cotacao> query = entityManager.createQuery(sql, getClasseEntidade());

		query.setParameter("data", cotacao.getData());
		query.setParameter("origem", cotacao.getOrigem());
		query.setParameter("destino", cotacao.getDestino());

		if (!query.getResultList().isEmpty()) {
			throw new AlreadyExistentEntityException("Cotação já existe para essas moedas e data!");
		}
	}

	@Override
	public Cotacao buscarCotacaoInternet(Moeda origem, Moeda destino) {

		Cotacao cotacao = new Cotacao();

		cotacao.setData(LocalDate.now(DataUtil.CLOCK));
		cotacao.setDestino(destino);
		cotacao.setOrigem(origem);
		cotacao.setTaxa(cotacaoRepositorio.getCotacao(origem, destino));

		return cotacao;
	}

	@Override
	protected String getTopicName() {
		return "cotacao";
	}
}
