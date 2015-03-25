package org.leo.despesas.aplicacao.debitavel;

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
	@SuppressWarnings("unchecked")
	public List<Debitavel> listar() {
		return entityManager.createQuery("SELECT d FROM Debitavel d").getResultList();
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
