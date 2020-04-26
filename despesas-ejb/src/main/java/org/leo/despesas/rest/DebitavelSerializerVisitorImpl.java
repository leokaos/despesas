package org.leo.despesas.rest;

import java.math.BigDecimal;
import java.util.Map;

import org.leo.despesas.dominio.debitavel.BandeiraCartaoCredito;
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Investimento;
import org.leo.despesas.dominio.debitavel.Periodicidade;

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

	@Override
	public void visit(Investimento investimento) {
		investimento.setMontante(new BigDecimal(mapaAtributos.get("montante")));
		investimento.setPeriodicidade(Periodicidade.valueOf(mapaAtributos.get("periodicidade")));
		investimento.setRendimento(new BigDecimal(mapaAtributos.get("rendimento")));
	}
}
