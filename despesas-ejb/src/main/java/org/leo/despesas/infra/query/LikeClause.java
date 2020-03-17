package org.leo.despesas.infra.query;

import javax.persistence.Query;

public final class LikeClause implements Clause {

	private String property;
	private String value;

	public LikeClause(String property, String value) {
		super();

		this.property = property;
		this.value = value;
	}

	@Override
	public void colocarClause(StringBuilder builder) {
		builder.append("LOWER(").append(property).append(") LIKE :").append(property);
	}

	@Override
	public void colocarValor(Query query) {
		query.setParameter(property, "%" + value.toLowerCase() + "%");
	}

}
