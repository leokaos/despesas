package org.leo.despesas.dominio.tipodespesa;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.leo.despesas.dominio.TipoDespesa;

@Stateless
public class TipoDespesaFacadeImpl implements TipoDespesaFacade {

	@PersistenceContext(unitName = "despesasPU")
	private EntityManager entityManager;

	@Override
	@SuppressWarnings("unchecked")
	public List<TipoDespesa> listar() {
		return entityManager.createQuery("SELECT tipodespesa FROM TipoDespesa tipodespesa ORDER BY tipodespesa.descricao").getResultList();
	}

	@Override
	public TipoDespesa buscarPorId(Object id) {
		return entityManager.find(TipoDespesa.class, (Long) id);
	}

	@Override
	public void inserir(TipoDespesa t) {
		entityManager.persist(t);
	}

	@Override
	public void salvar(TipoDespesa t) {
		entityManager.merge(t);
	}

	@Override
	public void deletar(Long id) {
		entityManager.remove(buscarPorId(id));
	}
}