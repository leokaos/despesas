package org.leo.despesas.aplicacao.fatura;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.Query;

import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.rest.infra.AbstractFacade;

@Stateless
public class FaturaFacadeImpl extends AbstractFacade<Fatura> implements FaturaFacade {

	@Override
	protected Class<Fatura> getClasseEntidade() {
		return Fatura.class;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Fatura> buscarFaturaPorCartaoCredito(CartaoCredito cartaoCredito) {
		List<Fatura> faturas = new ArrayList<>();

		Query query = entityManager.createQuery("SELECT f FROM Fatura f WHERE f.cartao = :cartao");

		query.setParameter("cartao", cartaoCredito);

		faturas.addAll(query.getResultList());

		return faturas;
	}

}