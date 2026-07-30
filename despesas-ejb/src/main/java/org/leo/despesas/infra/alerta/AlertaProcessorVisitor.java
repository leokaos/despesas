package org.leo.despesas.infra.alerta;

import org.leo.despesas.dominio.alerta.AlertaDespesaRecorrente;
import org.leo.despesas.dominio.alerta.AlertaLimitePagamentoDivida;
import org.leo.despesas.dominio.alerta.AlertaPagamentoFaturaCartao;

public interface AlertaProcessorVisitor {

	void visit(AlertaLimitePagamentoDivida alerta);

	void visit(AlertaPagamentoFaturaCartao alerta);

	void visit(AlertaDespesaRecorrente alerta);

}
