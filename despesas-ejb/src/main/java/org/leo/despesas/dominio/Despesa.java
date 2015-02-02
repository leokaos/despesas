package org.leo.despesas.dominio;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "despesa", schema = "despesas_db")
@DiscriminatorValue(value = "D")
public class Despesa extends Movimentacao {

	@Column(name = "paga")
	private boolean paga;

	@ManyToOne
	@JoinColumn(name = "tipo_despesa_id")
	private TipoDespesa tipoDespesa;

	public Despesa() {
		super();
	}

	public boolean isPaga() {
		return paga;
	}

	public void setPaga(boolean paga) {
		this.paga = paga;
	}

	public TipoDespesa getTipoDespesa() {
		return tipoDespesa;
	}

	public void setTipoDespesa(TipoDespesa tipoDespesa) {
		this.tipoDespesa = tipoDespesa;
	}

	public void pagar() {
		this.conta.pagar(this);

		setPaga(true);
		fechar();
	}
}
