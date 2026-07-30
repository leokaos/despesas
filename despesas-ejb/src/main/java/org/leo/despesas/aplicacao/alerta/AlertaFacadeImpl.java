package org.leo.despesas.aplicacao.alerta;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.alerta.Alerta;
import org.leo.despesas.dominio.alerta.AlertaFiltro;
import org.leo.despesas.infra.AbstractFacade;

@Stateless
public class AlertaFacadeImpl extends AbstractFacade<Alerta, AlertaFiltro> implements AlertaFacade {

	@Override
	protected Class<Alerta> getClasseEntidade() {
		return Alerta.class;
	}

	@Override
	protected String getTopicName() {
		return "alerta";
	}

}
