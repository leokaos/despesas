package org.leo.despesas.infra;

import java.text.MessageFormat;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

public abstract class AbstractFacade<E> implements SimpleFacade<E> {

	private static final String SELECT_MODEL = "SELECT {1} FROM {0} {1}";

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	public AbstractFacade() {
		super();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<E> listar() {

		String className = getClasseEntidade().getSimpleName();
		String qlString = MessageFormat.format(SELECT_MODEL, className, className.toLowerCase());

		return entityManager.createQuery(qlString).getResultList();
	}

	@Override
	public E buscarPorId(Long id) {
		return entityManager.find(getClasseEntidade(), id);
	}

	@Override
	public void inserir(E t) {
		entityManager.persist(t);
	}

	@Override
	public void salvar(E t) {
		entityManager.merge(t);
	}

	@Override
	public void salvar(List<E> list) {
		for (E e : list) {
			if (e != null) {
				salvar(e);
			}
		}
	}

	@Override
	public void deletar(Long id) {
		entityManager.remove(buscarPorId(id));
	}

	protected abstract Class<E> getClasseEntidade();

}