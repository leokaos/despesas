package org.leo.despesas.infra;

import javax.persistence.Query;

public interface Clause {

	void colocarClause(StringBuilder builder);

	void colocarValor(Query query);

}
