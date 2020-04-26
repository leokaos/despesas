package org.leo.despesas.rest;

import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Investimento;

public interface DebitavelSerializerVisitor {

	void visit(Conta conta);

	void visit(CartaoCredito cartaoCredito);
	
	void visit(Investimento investimento);

}
