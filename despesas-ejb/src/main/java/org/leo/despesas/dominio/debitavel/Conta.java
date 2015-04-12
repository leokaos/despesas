package org.leo.despesas.dominio.debitavel;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Receita;

@Entity
@Table(name = "conta", schema = "despesas_db")
@DiscriminatorValue(value = Conta.CODIGO_TIPO)
public class Conta extends Debitavel {

	public static final String CODIGO_TIPO = "CONTA";

	@Column(name = "saldo")
	private BigDecimal saldo;

	public Conta() {
		super(Conta.CODIGO_TIPO);
	}

	public BigDecimal getSaldo() {
		return saldo;
	}

	public void setSaldo(BigDecimal saldo) {
		this.saldo = saldo;
	}

	@Override
	public void debitar(Despesa despesa) {
		setSaldo(getSaldo().subtract(despesa.getValor()));
	}

	@Override
	public void creditar(Receita receita) {
		setSaldo(getSaldo().add(receita.getValor()));
	}

	@Override
	public Despesa consolidar(Despesa despesa) {
		return despesa;
	}

}
