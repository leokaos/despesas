package org.leo.despesas.infra.query;

import javax.persistence.Query;

public final class LessClause implements Clause {

	private String property;
	private Object value;
	private boolean orEqual;

	public LessClause(String property, Object value, boolean orEqual) {
		super();
		this.property = property;
		this.value = value;
		this.orEqual = orEqual;
	}

	@Override
	public void colocarClause(StringBuilder builder) {

		if (orEqual) {
			builder.append(property).append(" <= ").append(":").append(property);
		} else {
			builder.append(property).append(" < ").append(":").append(property);
		}
	}

	@Override
	public void colocarValor(Query query) {
		query.setParameter(property, value);
	}

}
