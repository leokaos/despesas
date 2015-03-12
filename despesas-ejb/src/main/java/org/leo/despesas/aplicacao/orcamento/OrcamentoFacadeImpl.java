package org.leo.despesas.aplicacao.orcamento;

import java.util.Calendar;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.Query;

import org.leo.despesas.dominio.orcamento.Orcamento;
import org.leo.despesas.dominio.orcamento.OrcamentoFiltro;
import org.leo.despesas.infra.DataUtil;
import org.leo.despesas.rest.infra.AbstractFacade;

@Stateless
public class OrcamentoFacadeImpl extends AbstractFacade<Orcamento> implements OrcamentoFacade {

    @Override
    protected Class<Orcamento> getClasseEntidade() {
	return Orcamento.class;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Orcamento> buscarPorFiltro(OrcamentoFiltro filtro) {

	StringBuilder builder = new StringBuilder();

	builder.append("SELECT o FROM Orcamento o WHERE 1 = 1");

	if (filtro.hasDataInicial()) {
	    builder.append(" AND o.dataInicial >= :dataInicial");
	}

	if (filtro.hasDataFinal()) {
	    builder.append(" AND o.dataFinal <= :dataFinal");
	}

	builder.append(" ORDER BY o.tipoDespesa.descricao");

	Query query = entityManager.createQuery(builder.toString());

	if (filtro.hasDataInicial()) {
	    query.setParameter("dataInicial", DataUtil.truncate(filtro.getDataInicial(), Calendar.DAY_OF_MONTH));
	}

	if (filtro.hasDataFinal()) {
	    query.setParameter("dataFinal", DataUtil.maximo(filtro.getDataFinal(), Calendar.DAY_OF_MONTH));
	}

	return query.getResultList();
    }

}