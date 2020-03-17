package org.leo.despesas.rest;

import java.math.BigDecimal;
import java.util.Map;

import org.leo.despesas.dominio.debitavel.BandeiraCartaoCredito;
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Conta;

public class DebitavelSerializerVisitorImpl implements DebitavelSerializerVisitor {

	private Map<String, String> mapaAtributos;

	public DebitavelSerializerVisitorImpl(Map<String, String> mapaAtributos) {
		super();
		this.mapaAtributos = mapaAtributos;
	}

	@Override
	public void visit(Conta conta) {

		conta.setSaldo(new BigDecimal(mapaAtributos.get("saldo")));
	}
	@Override
	public void visit(CartaoCredito cartaoCredito) {

		cartaoCredito.setBandeiraCartaoCredito(BandeiraCartaoCredito.parse(mapaAtributos.get("bandeiraCartaoCredito")));
		cartaoCredito.setDiaDeFechamento(Integer.valueOf(mapaAtributos.get("diaDeFechamento")));
		cartaoCredito.setDiaDeVencimento(Integer.valueOf(mapaAtributos.get("diaDeVencimento")));
		cartaoCredito.setLimite(new BigDecimal(mapaAtributos.get("limite")));
	}
}
