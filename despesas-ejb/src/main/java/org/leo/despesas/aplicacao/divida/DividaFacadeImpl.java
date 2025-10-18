package org.leo.despesas.aplicacao.divida;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.debitavel.Divida;
import org.leo.despesas.dominio.debitavel.DividaFiltro;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.exception.DespesasException;

@Stateless
public class DividaFacadeImpl extends AbstractFacade<Divida, DividaFiltro> implements DividaFacade {

	@Override
	public List<Transferencia> getPagamentos(Long id) throws DespesasException {

		List<Transferencia> listaDeTransferencias = new ArrayList<Transferencia>();
		listaDeTransferencias.addAll(this.buscarPorId(id).getPagamentos());

		return listaDeTransferencias;
	}

	@Override
	protected Class<Divida> getClasseEntidade() {
		return Divida.class;
	}

}
