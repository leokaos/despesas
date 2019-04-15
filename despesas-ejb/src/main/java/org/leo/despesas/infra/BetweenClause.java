package org.leo.despesas.infra;

import javax.persistence.Query;

public final class BetweenClause implements Clause {

	private String property;
	private Object minimo;
	private Object maximo;

	public BetweenClause(String property, Object minimo, Object maximo) {
		super();

		this.property = property;
		this.minimo = minimo;
		this.maximo = maximo;
	}

	@Override
	public void colocarClause(StringBuilder builder) {
		builder.append(property).append(" BETWEEN ").append(":minimo").append(property).append(" AND ").append(":maximo").append(property);
	}

	@Override
	public void colocarValor(Query query) {
		query.setParameter("minimo" + property, minimo);
		query.setParameter("maximo" + property, maximo);
	}

}
