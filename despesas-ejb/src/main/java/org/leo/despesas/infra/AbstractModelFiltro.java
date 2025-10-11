package org.leo.despesas.infra;

import java.text.MessageFormat;
import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import javax.ws.rs.QueryParam;

import org.apache.commons.lang3.StringUtils;
import org.leo.despesas.infra.query.BetweenClause;
import org.leo.despesas.infra.query.Clause;
import org.leo.despesas.infra.query.EqualClause;
import org.leo.despesas.infra.query.GreaterClause;
import org.leo.despesas.infra.query.LessClause;
import org.leo.despesas.infra.query.LikeClause;
import org.leo.despesas.infra.query.NotEqual;

import com.google.common.collect.Lists;

public abstract class AbstractModelFiltro<T extends ModelEntity> implements ModelFiltro<T> {

	private List<Clause> clausulas = Lists.newArrayList();

	@QueryParam("filter")
	private String filter;

	private static final String SELECT_MODEL = "SELECT {1} FROM {0} {1}";

	@Override
	public List<T> getLista(EntityManager entityManager, Class<T> classeDaEntidade) {

		build();

		TypedQuery<T> query = entityManager.createQuery(buildQuery(classeDaEntidade), classeDaEntidade);

		Iterator<Clause> it = clausulas.iterator();

		while (it.hasNext()) {
			it.next().colocarValor(query);
		}

		return query.getResultList();
	}

	protected void build() {

	}

	private String buildQuery(Class<T> classeDaEntidade) {

		final String className = classeDaEntidade.getSimpleName();

		StringBuilder builder = new StringBuilder(MessageFormat.format(SELECT_MODEL, className, className.toLowerCase()));

		Iterator<Clause> it = clausulas.iterator();

		if (it.hasNext()) {
			builder.append(" WHERE");
		}

		while (it.hasNext()) {

			builder.append(" ");

			it.next().colocarClause(builder);

			if (it.hasNext()) {
				builder.append(" AND ");
			}

		}

		builder.append(" ORDER BY ").append(className.toLowerCase()).append(".").append(orderBy());

		return builder.toString();
	}

	protected void eq(String property, Object value) {

		if (value != null) {
			this.clausulas.add(new EqualClause(property, value));
		}

	}

	protected void between(String property, Object minimo, Object maximo) {

		if (minimo != null && maximo != null) {
			this.clausulas.add(new BetweenClause(property, minimo, maximo));
		}
	}

	protected void like(String property, String value) {

		if (value != null && !value.isEmpty()) {
			this.clausulas.add(new LikeClause(property, value));
		}

	}

	protected void greaterOrEqualThan(String property, Comparable<?> comparable) {

		if (comparable != null) {
			this.clausulas.add(new GreaterClause(property, comparable, true));
		}

	}

	protected void lessOrEqualThan(String property, Comparable<?> comparable) {

		if (comparable != null) {
			this.clausulas.add(new LessClause(property, comparable, true));
		}
	}

	protected void notEqual(String property, String value) {

		if (StringUtils.isNotEmpty(value)) {
			this.clausulas.add(new NotEqual(property, value));
		}

	}

	protected String orderBy() {
		return "id";
	}

}
