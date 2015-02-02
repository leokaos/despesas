package org.leo.despesas.dominio;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "tab_receita")
@DiscriminatorValue(value = "R")
public class Receita extends Movimentacao {

    @Column(name = "depositado")
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
	this.conta.depositar(this);

	setDepositado(true);
	fechar();
    }

}
