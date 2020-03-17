package org.leo.despesas.infra.query;

import java.text.MessageFormat;

import javax.persistence.Query;

public class NotEqual implements Clause {

	private static final String FORMAT = "{0} != {1}";

	private String property;
	private Object value;

	public NotEqual(String property, Object value) {
		super();
		this.property = property;
		this.value = value;
	}

	@Override
	public void colocarClause(StringBuilder builder) {
		builder.append(MessageFormat.format(FORMAT, property, value));
	}

	@Override
	public void colocarValor(Query query) {
		query.setParameter(property, value);
	}

}
