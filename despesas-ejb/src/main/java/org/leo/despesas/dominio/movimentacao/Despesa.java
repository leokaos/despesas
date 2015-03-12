package org.leo.despesas.dominio.movimentacao;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;

@Entity
@Table(name = "despesa", schema = "despesas_db")
@DiscriminatorValue(value = "D")
public class Despesa extends Movimentacao {

	@Column(name = "paga")
	private boolean paga;

	@ManyToOne
	@JoinColumn(name = "tipo_despesa_id")
	private TipoDespesa tipoDespesa;

	@ManyToOne
	@JoinColumn(name = "fatura_id", nullable = true)
	private Fatura fatura;

	@Transient
	private String parcelamento;

	@Transient
	private Integer numeroParcelas;

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

	public String getParcelamento() {
		return parcelamento;
	}

	public void setParcelamento(String parcelamento) {
		this.parcelamento = parcelamento;
	}

	public Integer getNumeroParcelas() {
		return numeroParcelas;
	}

	public void setNumeroParcelas(Integer numeroParcelas) {
		this.numeroParcelas = numeroParcelas;
	}

	public boolean hasParcelamento() {
		return parcelamento != null;
	}

	public void pagar() {
		debitavel.debitar(this);

		setPaga(true);
		fechar();
	}

}
