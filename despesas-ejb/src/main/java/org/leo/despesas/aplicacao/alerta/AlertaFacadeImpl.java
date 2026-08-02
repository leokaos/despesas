package org.leo.despesas.aplicacao.alerta;

import java.util.List;

import javax.ejb.Stateless;
import javax.inject.Inject;

import org.leo.despesas.dominio.alerta.Alerta;
import org.leo.despesas.dominio.alerta.AlertaFiltro;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.alerta.AlertaProcessorVisitor;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.infra.exception.ValidationEntityException;

@Stateless
public class AlertaFacadeImpl extends AbstractFacade<Alerta, AlertaFiltro> implements AlertaFacade {

	@Inject
	private AlertaProcessorVisitor visitor;

	@Override
	protected Class<Alerta> getClasseEntidade() {
		return Alerta.class;
	}

	@Override
	protected String getTopicName() {
		return "alerta";
	}

	@Override
	public void gerarNotificacoes() throws DespesasException {

		List<Alerta> alertas = listarTodos();

		for (Alerta alerta : alertas) {
			alerta.accept(visitor);
		}
	}

	@Override
	protected void preDeletar(Alerta entity) throws DespesasException {

		boolean notificacoesEmAberto = entity.getNotificacoes().stream().anyMatch(notificaoca -> !notificaoca.isExecutado());

		if (notificacoesEmAberto) {
			throw new ValidationEntityException("Ainda existem notificações em aberto para esse alerta!");
		}

	}

}
