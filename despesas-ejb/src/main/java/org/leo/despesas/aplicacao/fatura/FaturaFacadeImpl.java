package org.leo.despesas.aplicacao.fatura;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.TypedQuery;

import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.debitavel.FaturaFiltro;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.exception.DespesasException;

import com.google.common.collect.Lists;

@Stateless
public class FaturaFacadeImpl extends AbstractFacade<Fatura, FaturaFiltro> implements FaturaFacade {

	@Override
	protected Class<Fatura> getClasseEntidade() {
		return Fatura.class;
	}

	@Override
	public List<Fatura> buscarFaturaPorCartaoCredito(CartaoCredito cartaoCredito) {

		List<Fatura> faturas = Lists.newArrayList();

		TypedQuery<Fatura> query = entityManager.createQuery("SELECT f FROM Fatura f WHERE f.cartao = :cartao ORDER BY f.dataFechamento", Fatura.class);

		query.setParameter("cartao", cartaoCredito);

		faturas.addAll(query.getResultList());

		return faturas;
	}

	@Override
	protected void preDeletar(Fatura fatura) throws DespesasException {

		if (fatura.hasDespesas()) {
			throw new DespesasException("Fatura contém despesas!");
		}
	}

}