package org.leo.despesas.aplicacao.orcamento;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;

import org.leo.despesas.aplicacao.despesa.DespesaFacade;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.DespesaFiltro;
import org.leo.despesas.dominio.orcamento.Orcamento;
import org.leo.despesas.dominio.orcamento.OrcamentoFiltro;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.Moeda;
import org.leo.despesas.infra.exception.AlreadyExistentEntityException;
import org.leo.despesas.infra.exception.DespesasException;

@Stateless
public class OrcamentoFacadeImpl extends AbstractFacade<Orcamento, OrcamentoFiltro> implements OrcamentoFacade {

	@EJB
	private DespesaFacade despesaFacade;

	@Override
	protected Class<Orcamento> getClasseEntidade() {
		return Orcamento.class;
	}

	@Override
	protected void preInserir(Orcamento t) throws DespesasException {

		OrcamentoFiltro filtro = new OrcamentoFiltro();
		filtro.setDataInicial(t.getDataInicial());
		filtro.setDataFinal(t.getDataFinal());
		filtro.setTipoDespesa(t.getTipoDespesa().getDescricao());

		if (this.listar(filtro).size() > 0) {
			throw new AlreadyExistentEntityException("Orçamento já existe!");
		}
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
		filtro.setMoeda(Moeda.EURO);
		List<Despesa> despesas = despesaFacade.listar(filtro);

		orcamento.setDespesaDoOrcamento(despesas);
		orcamento.consolidar();

		return orcamento;
	}

	@Override
	protected String getTopicName() {
		return "orcamento";
	}

}