package org.leo.despesas.dominio.conta;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.leo.despesas.dominio.Conta;

@Stateless
public class ContaFacadeImpl implements ContaFacade {

	@PersistenceContext(unitName = "despesasPU")
	private EntityManager entityManager;

	@Override
	@SuppressWarnings("unchecked")
	public List<Conta> listar() {
		return entityManager.createQuery("SELECT conta FROM Conta conta ORDER BY conta.nome").getResultList();
	}

	@Override
	public Conta buscarPorId(Object id) {
		return entityManager.find(Conta.class, (Long) id);
	}

	@Override
	public void inserir(Conta t) {
		entityManager.persist(t);
	}

	@Override
	public void salvar(Conta t) {
		entityManager.merge(t);
	}

	@Override
	public void deletar(Long id) {
		entityManager.remove(buscarPorId(id));
	}
}
