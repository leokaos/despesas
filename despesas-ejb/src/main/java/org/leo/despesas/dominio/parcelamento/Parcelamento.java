package org.leo.despesas.dominio.parcelamento;

import java.math.BigDecimal;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.leo.despesas.dominio.movimentacao.Despesa;

public abstract class Parcelamento {

	private static final String FORMATO_DESCRICAO = "{0} {1}/{2}";

	protected Parcelamento() {
		super();
	}

	public List<Despesa> parcelar(final Despesa despesa,final BigDecimal numeroParcelas) {
		final List<Despesa> despesas = new ArrayList<Despesa>();

		final BigDecimal valorParcela = despesa.getValor().divide(numeroParcelas);

		for (int x = 0 ; x < numeroParcelas.intValue() ; x++) {
			final Despesa despesaParcelada = new Despesa();

			despesaParcelada.setDescricao(createDescricao(x,despesa.getDescricao(),numeroParcelas));
			despesaParcelada.setVencimento(getDataParcela(x,despesa));
			despesaParcelada.setValor(valorParcela);

			despesaParcelada.setDebitavel(despesa.getDebitavel());
			despesaParcelada.setTipo(despesa.getTipo());
			despesaParcelada.setPaga(despesa.isPaga());
			despesaParcelada.setMoeda(despesa.getMoeda());

			despesas.add(despesaParcelada);
		}

		return despesas;
	}

	private String createDescricao(final int x,final String descricao,final BigDecimal numeroParcelas) {
		return MessageFormat.format(FORMATO_DESCRICAO,descricao,x + 1,numeroParcelas);
	}

	public static Parcelamento create(final String codigo) {

		if (ParcelamentoAnual.CODIGO.equals(codigo)) {

			return new ParcelamentoAnual();

		} else if (ParcelamentoMensal.CODIGO.equals(codigo)) {

			return new ParcelamentoMensal();

		} else if (ParcelamentoSemanal.CODIGO.equals(codigo)) {

			return new ParcelamentoSemanal();

		} else if (ParcelamentoSemestral.CODIGO.equals(codigo)) {

			return new ParcelamentoSemestral();
		}

		return null;
	}

	public abstract Date getDataParcela(int numeroParcela,Despesa despesa);

	public abstract String getCodigo();

}
