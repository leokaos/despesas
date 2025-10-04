package org.leo.despesas.rest;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.leo.despesas.dominio.debitavel.BandeiraCartaoCredito;
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Divida;
import org.leo.despesas.dominio.debitavel.Investimento;
import org.leo.despesas.dominio.debitavel.Periodicidade;

public class DebitavelSerializerVisitorImpl implements DebitavelSerializerVisitor {

	private static final DateFormat FORMAT = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

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
		cartaoCredito.setBandeira(BandeiraCartaoCredito.parse(mapaAtributos.get("bandeira")));
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

	@Override
	public void visit(Divida divida) {
		divida.setValorTotal(new BigDecimal(mapaAtributos.get("valorTotal")));
		divida.setPeriodicidade(Periodicidade.valueOf(mapaAtributos.get("periodicidade")));
		divida.setDataInicio(getDateOrNull(mapaAtributos.get("dataInicio")));
	}

	private Date getDateOrNull(String value) {
		try {
			return FORMAT.parse(value);
		} catch (ParseException e) {
			try {
				return new Date(Integer.valueOf(value));
			} catch (NumberFormatException ex) {
				return null;
			}
		}

	}
}
