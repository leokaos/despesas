package org.leo.despesas.dominio.parcelamento;

import java.math.BigDecimal;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.leo.despesas.dominio.movimentacao.Despesa;

public abstract class Parcelamento {

	private static final String FORMATO_DESCRICAO = "{0} {1}/{2}";

	protected final BigDecimal numeroParcelas;
	protected final Despesa despesa;

	public Parcelamento(BigDecimal numeroParcelas, Despesa despesa) {
		super();
		this.numeroParcelas = numeroParcelas;
		this.despesa = despesa;
	}

	public List<Despesa> parcelar() {
		List<Despesa> despesas = new ArrayList<Despesa>();

		BigDecimal valorParcela = despesa.getValor().divide(numeroParcelas);

		for (int x = 0; x < numeroParcelas.intValue(); x++) {
			Despesa despesaParcelada = new Despesa();

			despesaParcelada.setDescricao(createDescricao(x));
			despesaParcelada.setVencimento(getDataParcela(x));
			despesaParcelada.setValor(valorParcela);

			despesaParcelada.setDebitavel(despesa.getDebitavel());
			despesaParcelada.setTipoDespesa(despesa.getTipoDespesa());

			despesas.add(despesaParcelada);
		}

		return despesas;
	}

	private String createDescricao(int x) {
		return MessageFormat.format(FORMATO_DESCRICAO, despesa.getDescricao(), x + 1, numeroParcelas);
	}

	public static Parcelamento create(String codigo, BigDecimal numeroParcelas, Despesa despesa) {

		if (ParcelamentoAnual.CODIGO.equals(codigo)) {

			return new ParcelamentoAnual(numeroParcelas, despesa);

		} else if (ParcelamentoMensal.CODIGO.equals(codigo)) {

			return new ParcelamentoMensal(numeroParcelas, despesa);

		} else if (ParcelamentoSemanal.CODIGO.equals(codigo)) {

			return new ParcelamentoSemanal(numeroParcelas, despesa);

		} else if (ParcelamentoSemestral.CODIGO.equals(codigo)) {

			return new ParcelamentoSemestral(numeroParcelas, despesa);
		}

		return null;
	}

	public abstract Date getDataParcela(int numeroParcela);

	public abstract String getCodigo();

}
