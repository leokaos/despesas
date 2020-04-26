package org.leo.despesas.dominio.movimentacao;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.leo.despesas.dominio.debitavel.Investimento;
import org.leo.despesas.dominio.tipomovimentacao.TipoReceita;

@Entity
@Table(name = "receita", schema = "despesas_db")
@PrimaryKeyJoinColumn(name = "id")
public class Receita extends Movimentacao {

	private static final long serialVersionUID = -2809658495598686884L;

	@Column(name = "depositado")
	private boolean depositado;

	@ManyToOne
	@JoinColumn(name = "tipo_receita_id")
	private TipoReceita tipo;

	@ManyToOne
	@JoinColumn(name = "investimento_id")
	private Investimento investimento;

	public Receita() {
		super();
	}

	public boolean isDepositado() {
		return depositado;
	}

	public void setDepositado(final boolean depositado) {
		this.depositado = depositado;
	}

	public TipoReceita getTipo() {
		return tipo;
	}

	public void setTipo(final TipoReceita tipo) {
		this.tipo = tipo;
	}

	public Investimento getInvestimento() {
		return investimento;
	}

	public void setInvestimento(Investimento investimento) {
		this.investimento = investimento;
	}

	public void depositar() {
		this.debitavel.creditar(this);

		setDepositado(true);

		fechar();
	}

	@Override
	@JsonIgnore
	public BigDecimal getValorContabilistico() {
		return this.getValor();
	}

}
