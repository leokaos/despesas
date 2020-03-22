package org.leo.despesas.dominio.movimentacao;

import java.math.BigDecimal;
import java.text.MessageFormat;
import java.util.Date;

import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;

public class DespesaRecorrente {

	private static final String FORMATO_DESCRICAO = "{0} {1}";

	private BigDecimal valor;

	private Date dataInicial;

	private Peridiocidade peridiciodade;

	private Debitavel debitavel;

	private String descricao;

	private TipoDespesa tipoDespesa;

	public DespesaRecorrente() {
		super();
	}

	public BigDecimal getValor() {
		return valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

	public Date getDataInicial() {
		return dataInicial;
	}

	public void setDataInicial(Date dataInicial) {
		this.dataInicial = dataInicial;
	}

	public Peridiocidade getPeridiciodade() {
		return peridiciodade;
	}

	public void setPeridiciodade(Peridiocidade peridiciodade) {
		this.peridiciodade = peridiciodade;
	}

	public Debitavel getDebitavel() {
		return debitavel;
	}

	public void setDebitavel(Debitavel debitavel) {
		this.debitavel = debitavel;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public TipoDespesa getTipoDespesa() {
		return tipoDespesa;
	}

	public void setTipoDespesa(TipoDespesa tipoDespesa) {
		this.tipoDespesa = tipoDespesa;
	}

	public Despesa gerarDespesa() {

		Despesa despesa = new Despesa();

		despesa.setDebitavel(debitavel);
		despesa.setDescricao(MessageFormat.format(FORMATO_DESCRICAO, descricao, "leo"));
		despesa.setMoeda(debitavel.getMoeda());
		despesa.setTipo(tipoDespesa);
		despesa.setValor(valor);

//		despesa.setPagamento(pagamento);
//		despesa.setVencimento(vencimento);

		return despesa;
	}

}
