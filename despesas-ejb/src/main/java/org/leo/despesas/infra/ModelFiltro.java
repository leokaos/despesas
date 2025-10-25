package org.leo.despesas.infra;

import java.util.List;

import javax.persistence.EntityManager;

public interface ModelFiltro<T extends ModelEntity> {

	List<T> getLista(EntityManager entityManager, Class<T> classeDaEntidade);

	long count(EntityManager entityManager, Class<T> classeDaEntidade);

}
