package org.leo.despesas.dominio.movimentacao;


public class Receita extends Movimentacao {

	private boolean depositado;

	public Receita() {
		super();
	}

	public boolean isDepositado() {
		return depositado;
	}

	public void setDepositado(boolean depositado) {
		this.depositado = depositado;
	}

	public void depositar() {
		this.debitavel.creditar(this);

		setDepositado(true);

		fechar();
	}

}
