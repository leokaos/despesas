package org.leo.despesas.rest.infra;

import java.text.MessageFormat;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.leo.despesas.infra.exception.AlreadyExistentEntityException;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.infra.exception.NotFoundEntityException;

public abstract class AbstractFacade<E extends ModelEntity> implements SimpleFacade<E> {

	private static final String SELECT_MODEL = "SELECT {1} FROM {0} {1}";

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	public AbstractFacade() {
		super();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<E> listar() {

		final String className = getClasseEntidade().getSimpleName();
		final String qlString = MessageFormat.format(SELECT_MODEL, className, className.toLowerCase());

		return entityManager.createQuery(qlString).getResultList();
	}

	@Override
	public E buscarPorId(final Long id) throws DespesasException {
		final E entity = entityManager.find(getClasseEntidade(), id);

		if (entity == null) {
			throw new NotFoundEntityException(getClasseEntidade() + " not found with id " + id);
		}

		return entity;
	}

	@Override
	public void inserir(final E t) throws DespesasException {

		try {

			if (t.getId() != null) {
				buscarPorId(t.getId());
				throw new AlreadyExistentEntityException(getClasseEntidade() + " with id " + t.getId() + " already exists!");
			} else {
				entityManager.persist(t);
			}

		} catch (final NotFoundEntityException e) {
			entityManager.persist(t);
		}
	}

	@Override
	public void salvar(final E t) {
		entityManager.merge(t);
	}

	@Override
	public void salvar(final List<E> list) throws DespesasException {
		for (final E e : list) {
			if (e != null) {
				inserir(e);
			}
		}
	}

	@Override
	public void deletar(final Long id) throws DespesasException {
		entityManager.remove(buscarPorId(id));
	}

	protected abstract Class<E> getClasseEntidade();

}
