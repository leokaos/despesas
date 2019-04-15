package org.leo.despesas.aplicacao.orcamento;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;

import org.leo.despesas.aplicacao.despesa.DespesaFacade;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.DespesaFiltro;
import org.leo.despesas.dominio.orcamento.Orcamento;
import org.leo.despesas.dominio.orcamento.OrcamentoFiltro;
import org.leo.despesas.rest.infra.AbstractFacade;

@Stateless
public class OrcamentoFacadeImpl extends AbstractFacade<Orcamento, OrcamentoFiltro> implements OrcamentoFacade {

	@EJB
	private DespesaFacade despesaFacade;

	@Override
	protected Class<Orcamento> getClasseEntidade() {
		return Orcamento.class;
	}

	@Override
	public List<Orcamento> listar(OrcamentoFiltro filtro) {

		List<Orcamento> orcamentos = super.listar(filtro);

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
		filtro.setTipoDespesa(orcamento.getTipoDespesa().getDescricao());

		List<Despesa> despesas = despesaFacade.listar(filtro);

		orcamento.setDespesaDoOrcamento(despesas);
		orcamento.consolidar();

		return orcamento;
	}

}