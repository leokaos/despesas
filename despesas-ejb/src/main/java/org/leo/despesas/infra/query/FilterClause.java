package org.leo.despesas.infra.query;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

@FunctionalInterface
public interface FilterClause {

	Predicate toPredicate(CriteriaBuilder cb, Root<?> root);

}
