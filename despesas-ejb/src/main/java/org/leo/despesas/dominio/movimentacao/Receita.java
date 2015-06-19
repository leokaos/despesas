package org.leo.despesas.dominio.movimentacao;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.leo.despesas.dominio.tipomovimentacao.TipoReceita;

@Entity
@Table(name = "receita", schema = "despesas_db")
@DiscriminatorValue(value = "R")
public class Receita extends Movimentacao {

	@Column(name = "depositado")
	private boolean depositado;

	@ManyToOne
	@JoinColumn(name = "tipo_receita_id")
	private TipoReceita tipo;

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

	public void depositar() {
		this.debitavel.creditar(this);

		setDepositado(true);

		fechar();
	}

}
