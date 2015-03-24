package org.leo.despesas.aplicacao.orcamento;

import java.util.Calendar;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.Query;

import org.leo.despesas.aplicacao.despesa.DespesaFacade;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.DespesaFiltro;
import org.leo.despesas.dominio.orcamento.Orcamento;
import org.leo.despesas.dominio.orcamento.OrcamentoFiltro;
import org.leo.despesas.infra.DataUtil;
import org.leo.despesas.rest.infra.AbstractFacade;

@Stateless
public class OrcamentoFacadeImpl extends AbstractFacade<Orcamento> implements OrcamentoFacade {

	@EJB
	private DespesaFacade despesaFacade;

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

		if (filtro.hasTipoDespesa()) {
			builder.append(" AND o.tipoDespesa.descricao = :descricao");
		}

		builder.append(" ORDER BY o.tipoDespesa.descricao");

		Query query = entityManager.createQuery(builder.toString());

		if (filtro.hasDataInicial()) {
			query.setParameter("dataInicial", DataUtil.truncate(filtro.getDataInicial(), Calendar.DAY_OF_MONTH));
		}

		if (filtro.hasDataFinal()) {
			query.setParameter("dataFinal", DataUtil.maximo(filtro.getDataFinal(), Calendar.DAY_OF_MONTH));
		}

		if (filtro.hasTipoDespesa()) {
			query.setParameter("descricao", filtro.getTipoDespesa());
		}

		return query.getResultList();
	}

	@Override
	public List<Orcamento> listar() {
		List<Orcamento> orcamentos = super.listar();

		for (Orcamento orcamento : orcamentos) {
			consolidar(orcamento);
		}

		return orcamentos;
	}

	@Override
	public Orcamento consolidar(Orcamento orcamento) {

		DespesaFiltro filtro = new DespesaFiltro();

		filtro.setDataInicial(orcamento.getDataInicial());
		filtro.setDataFinal(orcamento.getDataFinal());
		filtro.setTipoDespesa(orcamento.getTipoDespesa());

		List<Despesa> despesas = despesaFacade.buscarPorFiltro(filtro);

		orcamento.setDespesaDoOrcamento(despesas);
		orcamento.consolidar();

		return orcamento;
	}

}