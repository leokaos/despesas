package org.leo.despesas.infra.query;

import java.util.List;

import javax.persistence.Query;

public class InClause implements Clause {

	private String property;
	private List<?> values;

	public InClause(String property, List<?> values) {
		super();
		this.property = property;
		this.values = values;
	}

	@Override
	public void colocarClause(StringBuilder builder) {
		builder.append(property).append(" IN (:").append(property + "_items").append(")");
	}

	@Override
	public void colocarValor(Query query) {
		query.setParameter(property + "_items", values);
	}

}
