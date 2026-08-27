package org.leo.despesas.aplicacao.ativo;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.debitavel.Ativo;
import org.leo.despesas.dominio.debitavel.AtivoFiltro;
import org.leo.despesas.infra.AbstractFacade;

@Stateless
public class AtivoFacadeImpl extends AbstractFacade<Ativo, AtivoFiltro> implements AtivoFacade {

	@Override
	protected Class<Ativo> getClasseEntidade() {
		return Ativo.class;
	}

	@Override
	protected String getTopicName() {
		return "ativo";
	}

}
