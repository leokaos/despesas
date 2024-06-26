package org.leo.despesas.dominio.debitavel;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.rest.DebitavelSerializerVisitorImpl;

@Entity
@Table(name = "conta", schema = "despesas_db")
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
			this.saldo = getSaldo().add(transferencia.getValorReal());
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

	@Override
	public void estornar(Despesa despesa) {
		saldo = saldo.add(despesa.getValor());
	}

	@Override
	public void estornar(Receita receita) {
		saldo = saldo.subtract(receita.getValor());
	}

	@Override
	public void estornar(Transferencia transferencia) {

		if (this.equals(transferencia.getDebitavel())) {
			saldo = saldo.add(transferencia.getValor());
		} else if (this.equals(transferencia.getCreditavel())) {
			saldo = saldo.subtract(transferencia.getValor());
		}

	}

}
