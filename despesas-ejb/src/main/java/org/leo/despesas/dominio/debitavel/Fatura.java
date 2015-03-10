package org.leo.despesas.dominio.debitavel;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.infra.DataUtil;
import org.leo.despesas.infra.Periodo;

public class Fatura {

	private CartaoCredito cartao;
	private Date dataVencimento;
	private Date dataFechamento;
	private List<Despesa> despesas;

	public Fatura() {
		super();

		this.despesas = new ArrayList<Despesa>();
	}

	public Fatura(CartaoCredito cartao) {
		this();

		this.cartao = cartao;
	}

	public CartaoCredito getCartao() {
		return cartao;
	}

	public void setCartao(CartaoCredito cartao) {
		this.cartao = cartao;
	}

	public Date getDataVencimento() {
		return dataVencimento;
	}

	public void setDataVencimento(Date dataVencimento) {
		this.dataVencimento = dataVencimento;
	}

	public Date getDataFechamento() {
		return dataFechamento;
	}

	public void setDataFechamento(Date dataFechamento) {
		this.dataFechamento = dataFechamento;
	}

	public List<Despesa> getDespesas() {
		return despesas;
	}

	public void setDespesas(List<Despesa> despesas) {
		this.despesas = despesas;
	}

	public BigDecimal getValorFatura() {
		BigDecimal total = BigDecimal.ZERO;

		for (Despesa despesa : despesas) {
			total = total.add(despesa.getValor());
		}

		return total;
	}

	public boolean pertenceFatura(Date dataBase) {
		return getPeriodoVigencia().pertenceAoPeriodo(dataBase);
	}

	private Periodo getPeriodoVigencia() {
		return new Periodo(DataUtil.addDays(dataFechamento, -1), dataFechamento);
	}
}
