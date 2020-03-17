package org.leo.despesas.dominio.debitavel;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.rest.DebitavelSerializerVisitorImpl;

@Entity
@Table(name = "conta", schema = "despesas_db")
@DiscriminatorValue(value = Conta.CODIGO_TIPO)
public class Conta extends Debitavel {

	private static final long serialVersionUID = -6946595134001817926L;

	public static final String CODIGO_TIPO = "CONTA";

	@Column(name = "saldo")
	private BigDecimal saldo;

	public Conta() {
		super();

		setTipo(CODIGO_TIPO);
	}

	public BigDecimal getSaldo() {
		return saldo;
	}

	public void setSaldo(final BigDecimal saldo) {
		this.saldo = saldo;
	}

	public String getTipo() {
		return CODIGO_TIPO;
	}

	@Override
	public void debitar(final Despesa despesa) {
		this.saldo = getSaldo().subtract(despesa.getValor());
	}

	@Override
	public void creditar(final Receita receita) {
		this.saldo = getSaldo().add(receita.getValor());
	}

	@Override
	public void transferir(final Transferencia transferencia) {

		if (transferencia.getCreditavel().getId().equals(getId())) {
			this.saldo = getSaldo().add(transferencia.getValor());
		} else if (transferencia.getDebitavel().getId().equals(getId())) {
			this.saldo = getSaldo().subtract(transferencia.getValor());
		} else {
			throw new IllegalArgumentException();
		}
	}

	@Override
	public Despesa consolidar(final Despesa despesa) {
		return despesa;
	}

	@Override
	public void accept(DebitavelSerializerVisitorImpl visitor) {
		visitor.visit(this);
	}

}
