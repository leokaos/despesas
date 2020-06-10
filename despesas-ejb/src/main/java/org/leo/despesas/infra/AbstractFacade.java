package org.leo.despesas.infra;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.leo.despesas.infra.exception.AlreadyExistentEntityException;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.infra.exception.NotFoundEntityException;

import com.google.common.collect.Lists;

public abstract class AbstractFacade<E extends ModelEntity, F extends ModelFiltro<E>> implements SimpleFacade<E, F> {

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	public AbstractFacade() {
		super();
	}

	@Override
	public List<E> listar(F filtro) {
		return filtro.getLista(entityManager, getClasseEntidade());
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
	public E inserir(final E t) throws DespesasException {

		try {

			if (t.getId() != null) {
				buscarPorId(t.getId());
				throw new AlreadyExistentEntityException(getClasseEntidade() + " with id " + t.getId() + " already exists!");
			} else {
				preInserir(t);
				entityManager.persist(t);
				posInserir(t);
			}

		} catch (final NotFoundEntityException e) {
			entityManager.persist(t);
		}
		
		return t;
	}

	protected void preInserir(E t) {
				
	}
	
	protected void posInserir(E t) {
		
	}

	@Override
	public E salvar(final E t) {

		E antigo = entityManager.find(getClasseEntidade(), t.getId());
		
		entityManager.detach(antigo);
		
		preSalvar(antigo,t);

		E result = entityManager.merge(t);
		
		posSalvar(antigo, t);
		
		return result;
	}
	
	protected void preSalvar(E antigo, E novo) {
		
	}

	protected void posSalvar(E antigo, E novo) {
		
	}

	@Override
	public List<E> salvar(final List<E> list) throws DespesasException {
		
		List<E> result = Lists.newArrayList();
		
		for (final E e : list) {
			if (e != null) {
				result.add(inserir(e));
			}
		}
		
		return result;
	}

	@Override
	public void deletar(final Long id) throws DespesasException {
		entityManager.remove(buscarPorId(id));
	}

	protected abstract Class<E> getClasseEntidade();

}
