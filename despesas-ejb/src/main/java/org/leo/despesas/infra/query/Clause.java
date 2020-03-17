package org.leo.despesas.infra.query;

import javax.persistence.Query;

public interface Clause {

	void colocarClause(StringBuilder builder);

	void colocarValor(Query query);

}
