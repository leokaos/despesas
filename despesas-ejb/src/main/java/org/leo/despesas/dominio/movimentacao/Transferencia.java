package org.leo.despesas.dominio.movimentacao;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.leo.despesas.dominio.debitavel.Debitavel;

@Entity
@Table(name = "transferencia",schema = "despesas_db")
@DiscriminatorValue(value = "T")
public class Transferencia extends Movimentacao {

	private static final long serialVersionUID = 4682865005993932139L;

	@ManyToOne
	@JoinColumn(name = "creditavel_id")
	private Debitavel creditavel;

	public Transferencia() {
		super();
	}

	public Debitavel getCreditavel() {
		return creditavel;
	}

	public void setCreditavel(Debitavel creditavel) {
		this.creditavel = creditavel;
	}

	public void transferir() {
		if (this.debitavel == null || this.creditavel == null) {
			throw new IllegalStateException();
		}

		this.debitavel.transferir(this);
		this.creditavel.transferir(this);
	}

}
