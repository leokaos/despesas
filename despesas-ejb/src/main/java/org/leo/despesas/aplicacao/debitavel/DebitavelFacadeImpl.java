package org.leo.despesas.aplicacao.debitavel;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.leo.despesas.dominio.debitavel.Debitavel;

@Stateless
public class DebitavelFacadeImpl implements DebitavelFacade {

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	@Override
	public List<Debitavel> listar() {
		List<Debitavel> listar = new ArrayList<>();

		for (Object object : entityManager.createQuery("SELECT d FROM Debitavel d").getResultList()) {
			Debitavel debitavel = (Debitavel) object;
			listar.add(debitavel.toDebitavel());
		}

		return listar;
	}

	@Override
	public void salvar(Debitavel debitavel) {
		entityManager.merge(debitavel);
	}

	@Override
	public Debitavel buscarPorId(Object id) {
		return entityManager.find(Debitavel.class, id);
	}

}
