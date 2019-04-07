package org.leo.despesas.dominio.debitavel;

public interface DebitavelSerializerVisitor {

	void visit(Conta conta);

	void visit(CartaoCredito cartaoCredito);

}
