package org.leo.despesas.aplicacao.investimento;

import java.math.BigDecimal;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;

import org.leo.despesas.aplicacao.receita.ReceitaFacade;
import org.leo.despesas.dominio.debitavel.Investimento;
import org.leo.despesas.dominio.debitavel.InvestimentoFiltro;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.ReceitaFiltro;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.exception.DespesasException;

@Stateless
public class InvestimentoFacadeImpl extends AbstractFacade<Investimento, InvestimentoFiltro> implements InvestimentoFacade {

	@EJB
	private ReceitaFacade receitaFacade;

	@Override
	public void consolidar(Investimento investimento) {

		ReceitaFiltro filtro = new ReceitaFiltro();
		filtro.setInvestimento(investimento);

		BigDecimal totalReceitas = BigDecimal.ZERO;

		for (Receita receita : receitaFacade.listar(filtro)) {
			totalReceitas = totalReceitas.add(receita.getValor());
		}

		investimento.setValorReceitas(totalReceitas);
	}

	@Override
	public List<Investimento> listar(InvestimentoFiltro filtro) {

		List<Investimento> investimentos = super.listar(filtro);

		for (Investimento investimento : investimentos) {
			consolidar(investimento);
		}

		return investimentos;
	}

	@Override
	public Investimento buscarPorId(Long id) throws DespesasException {
		Investimento investimento = super.buscarPorId(id);
		consolidar(investimento);
		return investimento;
	}

	@Override
	protected Class<Investimento> getClasseEntidade() {
		return Investimento.class;
	}

}