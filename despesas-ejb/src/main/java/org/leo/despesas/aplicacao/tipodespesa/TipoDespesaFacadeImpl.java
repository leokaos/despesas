package org.leo.despesas.aplicacao.tipodespesa;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;
import org.leo.despesas.infra.AbstractFacade;

@Stateless
public class TipoDespesaFacadeImpl extends AbstractFacade<TipoDespesa> implements TipoDespesaFacade {

	@Override
	protected Class<TipoDespesa> getClasseEntidade() {
		return TipoDespesa.class;
	}

}