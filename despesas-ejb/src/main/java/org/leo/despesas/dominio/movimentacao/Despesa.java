package org.leo.despesas.dominio.movimentacao;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;

@Entity
@Table(name = "despesa",schema = "despesas_db")
@DiscriminatorValue(value = "D")
public class Despesa extends Movimentacao {

	private static final long serialVersionUID = -832942623220660512L;

	@Column(name = "paga")
	private boolean paga;

	@ManyToOne
	@JoinColumn(name = "tipo_despesa_id")
	private TipoDespesa tipo;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "fatura_id",nullable = true)
	private Fatura fatura;

	public Despesa() {
		super();
	}

	public boolean isPaga() {
		return paga;
	}

	public void setPaga(final boolean paga) {
		this.paga = paga;
	}

	public TipoDespesa getTipo() {
		return tipo;
	}

	public void setTipo(final TipoDespesa tipo) {
		this.tipo = tipo;
	}

	@JsonIgnore
	public Fatura getFatura() {
		return fatura;
	}

	public void setFatura(final Fatura fatura) {
		this.fatura = fatura;
	}

	public void pagar() {
		debitavel.debitar(this);

		setPaga(true);
		fechar();
	}

	public Despesa consolidar() {
		return debitavel.consolidar(this);
	}

}
