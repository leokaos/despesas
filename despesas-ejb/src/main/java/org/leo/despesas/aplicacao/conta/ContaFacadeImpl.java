package org.leo.despesas.aplicacao.conta;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.infra.AbstractFacade;

@Stateless
public class ContaFacadeImpl extends AbstractFacade<Conta> implements ContaFacade {

	@Override
	protected Class<Conta> getClasseEntidade() {
		return Conta.class;
	}
}
