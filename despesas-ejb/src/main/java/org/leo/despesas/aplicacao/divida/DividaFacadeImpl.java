package org.leo.despesas.aplicacao.divida;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;

import org.leo.despesas.aplicacao.movimentacao.MovimentacaoFacade;
import org.leo.despesas.aplicacao.transferencia.TransferenciaFacade;
import org.leo.despesas.dominio.debitavel.Divida;
import org.leo.despesas.dominio.debitavel.DividaFiltro;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.dominio.movimentacao.TransferenciaFiltro;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.infra.exception.ValidationEntityException;

@Stateless
public class DividaFacadeImpl extends AbstractFacade<Divida, DividaFiltro> implements DividaFacade {

	@EJB
	private MovimentacaoFacade movimentacaoFacade;

	@EJB
	private TransferenciaFacade transferenciaFacade;

	@Override
	public List<Transferencia> getPagamentos(Long id) throws DespesasException {

		List<Transferencia> listaDeTransferencias = new ArrayList<Transferencia>();
		listaDeTransferencias.addAll(this.buscarPorId(id).getPagamentos());

		return listaDeTransferencias;
	}

	@Override
	protected void preSalvar(Divida antigo, Divida novo) throws DespesasException {

		if (antigo.getMoeda() != novo.getMoeda()) {

			long movimentacoes = movimentacaoFacade.buscarQuantidadeMovimentacaoPorDebitavel(antigo);

			TransferenciaFiltro filtro = new TransferenciaFiltro();
			filtro.setCreditavel(novo);

			long transferencias = transferenciaFacade.count(filtro);

			if (movimentacoes > 0 || transferencias > 0) {
				throw new ValidationEntityException("Divida não pode trocar de moeda pois existem movimentações atreladas a ela!");
			}

		}

	}

	@Override
	protected Class<Divida> getClasseEntidade() {
		return Divida.class;
	}

}
