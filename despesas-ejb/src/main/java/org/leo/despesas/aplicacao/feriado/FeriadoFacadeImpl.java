package org.leo.despesas.aplicacao.feriado;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.feriado.Feriado;
import org.leo.despesas.dominio.feriado.FeriadoFiltro;
import org.leo.despesas.infra.AbstractFacade;

@Stateless
public class FeriadoFacadeImpl extends AbstractFacade<Feriado, FeriadoFiltro> implements FeriadoFacade {

	@Override
	protected Class<Feriado> getClasseEntidade() {
		return Feriado.class;
	}

}
