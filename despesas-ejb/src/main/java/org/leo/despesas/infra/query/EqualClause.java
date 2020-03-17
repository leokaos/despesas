package org.leo.despesas.infra.query;

import javax.persistence.Query;

public final class EqualClause implements Clause {

	private String property;
	private Object value;

	public EqualClause(String property, Object value) {
		super();

		this.property = property;
		this.value = value;
	}

	@Override
	public void colocarClause(StringBuilder builder) {
		builder.append(property).append(" = ").append(":").append(property.replace(".", "_"));
	}

	@Override
	public void colocarValor(Query query) {
		query.setParameter(property.replace(".", "_"), value);
	}

}
