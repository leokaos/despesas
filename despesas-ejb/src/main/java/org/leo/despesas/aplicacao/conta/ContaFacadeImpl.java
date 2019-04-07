package org.leo.despesas.aplicacao.conta;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.ContaFiltro;
import org.leo.despesas.rest.infra.AbstractFacade;

@Stateless
public class ContaFacadeImpl extends AbstractFacade<Conta, ContaFiltro> implements ContaFacade {

	@Override
	protected Class<Conta> getClasseEntidade() {
		return Conta.class;
	}
}
