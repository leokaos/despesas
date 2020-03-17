package org.leo.despesas.aplicacao.meta;

import java.util.List;

import javax.ejb.Stateless;
import javax.inject.Inject;

import org.leo.despesas.aplicacao.movimentacao.MovimentacaoFacade;
import org.leo.despesas.dominio.meta.Meta;
import org.leo.despesas.dominio.meta.MetaFiltro;
import org.leo.despesas.dominio.movimentacao.Movimentacao;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.Periodo;

@Stateless
public class MetaFacadeImpl extends AbstractFacade<Meta, MetaFiltro> implements MetaFacade {

	@Inject
	private MovimentacaoFacade movimentacaoFacade;

	@Override
	public List<Meta> listar(MetaFiltro filtro) {

		List<Meta> lista = super.listar(filtro);

		for (Meta meta : lista) {
			meta.calcularSaldo(buscarMovimentos(meta.getMes().getPeriodo()));
		}

		return lista;
	}

	private List<Movimentacao> buscarMovimentos(Periodo periodo) {
		return movimentacaoFacade.buscarMovimentacaoPorPeriodo(periodo.getDataInicial(), periodo.getDataFinal());
	}

	@Override
	protected Class<Meta> getClasseEntidade() {
		return Meta.class;
	}

}
