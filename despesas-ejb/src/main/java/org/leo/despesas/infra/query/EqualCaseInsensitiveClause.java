package org.leo.despesas.infra.query;

import javax.persistence.Query;

public final class EqualCaseInsensitiveClause implements Clause {

	private String property;
	private Object value;

	public EqualCaseInsensitiveClause(String property, Object value) {
		super();

		this.property = property;
		this.value = value;
	}

	@Override
	public void colocarClause(StringBuilder builder) {
		builder.append("UPPER(").append(property).append(") = UPPER(").append(":").append(property.replace(".", "_")).append(")");
	}

	@Override
	public void colocarValor(Query query) {
		query.setParameter(property.replace(".", "_"), value);
	}

}
