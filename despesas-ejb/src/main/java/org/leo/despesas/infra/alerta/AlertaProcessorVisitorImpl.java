package org.leo.despesas.infra.alerta;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

import org.leo.despesas.dominio.alerta.AlertaDespesaRecorrente;
import org.leo.despesas.dominio.alerta.AlertaDespesaRecorrenteProcessor;
import org.leo.despesas.dominio.alerta.AlertaLimitePagamentoDivida;
import org.leo.despesas.dominio.alerta.AlertaLimitePagamentoDividaProcessor;
import org.leo.despesas.dominio.alerta.AlertaPagamentoFaturaCartao;
import org.leo.despesas.dominio.alerta.AlertaPagamentoFaturaCartaoProcessor;

@ApplicationScoped
public class AlertaProcessorVisitorImpl implements AlertaProcessorVisitor {

	@Inject
	private AlertaDespesaRecorrenteProcessor alertaDespesaRecorrenteProcessor;

	@Inject
	private AlertaLimitePagamentoDividaProcessor alertaLimitePagamentoDividaProcessor;

	@Inject
	private AlertaPagamentoFaturaCartaoProcessor alertaPagamentoFaturaCartaoProcessor;

	@Override
	public void visit(AlertaLimitePagamentoDivida alerta) {
		this.alertaLimitePagamentoDividaProcessor.processarAlerta(alerta);
	}

	@Override
	public void visit(AlertaPagamentoFaturaCartao alerta) {
		this.alertaPagamentoFaturaCartaoProcessor.processarAlerta(alerta);
	}

	@Override
	public void visit(AlertaDespesaRecorrente alerta) {
		this.alertaDespesaRecorrenteProcessor.processarAlerta(alerta);
	}

}
