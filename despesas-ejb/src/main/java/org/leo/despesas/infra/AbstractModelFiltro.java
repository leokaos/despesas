package org.leo.despesas.infra;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.ws.rs.QueryParam;

import org.apache.commons.lang3.StringUtils;
import org.leo.despesas.infra.exception.InvalidQueryException;
import org.leo.despesas.infra.query.FilterClause;

import com.github.tennaito.rsql.jpa.JpaPredicateVisitor;

import cz.jirutka.rsql.parser.RSQLParser;
import cz.jirutka.rsql.parser.RSQLParserException;
import cz.jirutka.rsql.parser.ast.Node;

public abstract class AbstractModelFiltro<T extends ModelEntity> implements ModelFiltro<T> {

	private List<FilterClause> clausulas = new ArrayList<>();

	@QueryParam("filter")
	private String filter;

	@QueryParam("order")
	private String order;

	@QueryParam("direction")
	private String direction;

	@QueryParam("query")
	private String query;

	@Override
	public List<T> getLista(EntityManager entityManager, Class<T> classeDaEntidade) {

		if (StringUtils.isEmpty(this.query)) {
			return buildAndQuery(entityManager, classeDaEntidade);
		} else {
			return parseAndQuery(entityManager, classeDaEntidade);
		}

	}

	private List<T> parseAndQuery(EntityManager entityManager, Class<T> classeDaEntidade) {

		try {

			Node rootNode = new RSQLParser().parse(this.query);

			CriteriaBuilder cb = entityManager.getCriteriaBuilder();
			CriteriaQuery<T> criteriaQuery = cb.createQuery(classeDaEntidade);
			Root<T> root = criteriaQuery.from(classeDaEntidade);

			JpaPredicateVisitor<T> visitor = new JpaPredicateVisitor<T>();
			visitor.defineRoot(root);
			visitor.getBuilderTools().setArgumentParser(new CustomArgumentParser());

			Predicate predicate = rootNode.accept(visitor, entityManager);

			criteriaQuery.where(predicate);

			return entityManager.createQuery(criteriaQuery).getResultList();

		} catch (RSQLParserException | IllegalArgumentException e) {
			throw new InvalidQueryException("Sintaxe inválida!", e);
		}

	}

	private List<T> buildAndQuery(EntityManager entityManager, Class<T> classeDaEntidade) {

		build();

		CriteriaBuilder cb = entityManager.getCriteriaBuilder();
		CriteriaQuery<T> criteriaQuery = cb.createQuery(classeDaEntidade);
		Root<T> root = criteriaQuery.from(classeDaEntidade);

		List<Predicate> predicates = new ArrayList<>();

		for (FilterClause clause : clausulas) {
			predicates.add(clause.toPredicate(cb, root));
		}

		if (!predicates.isEmpty()) {
			criteriaQuery.where(predicates.toArray(new Predicate[0]));
		}

		if (StringUtils.isNotBlank(order)) {

			Path<?> orderPath = root.get(order);

			if ("DESC".equalsIgnoreCase(direction)) {
				criteriaQuery.orderBy(cb.desc(orderPath));
			} else {
				criteriaQuery.orderBy(cb.asc(orderPath));
			}
		}

		return entityManager.createQuery(criteriaQuery).getResultList();
	}

	@Override
	public long count(EntityManager entityManager, Class<T> classeDaEntidade) {

		build();

		CriteriaBuilder cb = entityManager.getCriteriaBuilder();
		CriteriaQuery<Long> criteriaQuery = cb.createQuery(Long.class);
		Root<T> root = criteriaQuery.from(classeDaEntidade);

		criteriaQuery.select(cb.count(root));

		List<Predicate> predicates = new ArrayList<>();

		for (FilterClause clause : clausulas) {
			predicates.add(clause.toPredicate(cb, root));
		}

		if (!predicates.isEmpty()) {
			criteriaQuery.where(predicates.toArray(new Predicate[0]));
		}

		return entityManager.createQuery(criteriaQuery).getSingleResult();
	}

	protected void build() {

	}

	protected void eq(String property, Object value) {

		if (value != null) {
			clausulas.add((cb, root) -> cb.equal(root.get(property), value));
		}

	}

	protected void eqIgnoreCase(String property, String value) {

		if (value != null) {
			clausulas.add((cb, root) -> cb.equal(cb.lower(root.get(property)), value.toLowerCase()));
		}

	}

	protected void between(String property, Object minimo, Object maximo) {

		if (minimo != null && maximo != null) {
			clausulas.add((cb, root) -> cb.between(root.get(property), (Comparable) minimo, (Comparable) maximo));
		}
	}

	protected void like(String property, String value) {

		if (value != null && !value.isEmpty()) {
			clausulas.add((cb, root) -> cb.like(cb.lower(root.get(property)), "%" + value.toLowerCase() + "%"));
		}
	}

	protected void greaterOrEqualThan(String property, Comparable<?> value) {

		if (value != null) {
			clausulas.add((cb, root) -> cb.greaterThanOrEqualTo(root.get(property), (Comparable) value));
		}
	}

	protected void lessOrEqualThan(String property, Comparable<?> value) {

		if (value != null) {
			clausulas.add((cb, root) -> cb.lessThanOrEqualTo(root.get(property), (Comparable) value));
		}
	}

	protected void notEqual(String property, String value) {

		if (StringUtils.isNotEmpty(value)) {
			clausulas.add((cb, root) -> cb.notEqual(root.get(property), value));
		}
	}

	protected void in(String property, List<?> values) {

		if (values != null && !values.isEmpty()) {
			clausulas.add((cb, root) -> root.get(property).in(values));
		}
	}

	protected void order(String order, String direction) {
		this.order = order;
		this.direction = direction;
	}

}
