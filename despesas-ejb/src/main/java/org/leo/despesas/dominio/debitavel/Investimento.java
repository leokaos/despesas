package org.leo.despesas.dominio.debitavel;

import java.math.BigDecimal;
import java.math.RoundingMode;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.rest.DebitavelSerializerVisitorImpl;

@Entity
@Table(name = "investimento", schema = "despesas_db")
public class Investimento extends Debitavel {

	private static final long serialVersionUID = -1631655722211846016L;

	public static final String CODIGO_TIPO = "INVESTIMENTO";

	@Column(name = "montante")
	private BigDecimal montante;

	@Enumerated(EnumType.STRING)
	@Column(name = "periodicidade")
	private Periodicidade periodicidade;

	@Column(name = "rendimento")
	private BigDecimal rendimento;

	@Transient
	private BigDecimal valorReceitas;

	public Investimento() {
		super();

		setTipo(CODIGO_TIPO);
	}

	public BigDecimal getMontante() {
		return montante;
	}

	public void setMontante(BigDecimal montante) {
		this.montante = montante;
	}

	public Periodicidade getPeriodicidade() {
		return periodicidade;
	}

	public void setPeriodicidade(Periodicidade periodicidade) {
		this.periodicidade = periodicidade;
	}

	public BigDecimal getRendimento() {
		return rendimento;
	}

	public void setRendimento(BigDecimal rendimento) {
		this.rendimento = rendimento;
	}

	public BigDecimal getValorReceitas() {
		return valorReceitas;
	}

	public void setValorReceitas(BigDecimal valorReceitas) {
		this.valorReceitas = valorReceitas;
	}

	@Override
	public void debitar(Despesa despesa) {

	}

	@Override
	public void creditar(Receita receita) {

	}

	@Override
	public void transferir(Transferencia transferencia) {

	}

	@Override
	public Despesa consolidar(Despesa despesa) {
		return despesa;
	}

	@Override
	public void accept(DebitavelSerializerVisitorImpl visitor) {
		visitor.visit(this);
	}

	@Override
	public BigDecimal getSaldo() {
		return montante;
	}

	public BigDecimal getYield() {

		if (getValorReceitas() != null) {
			return getValorReceitas().divide(montante, RoundingMode.HALF_DOWN);
		}

		return BigDecimal.ZERO;
	}
	
	@Override
	public void estornar(Despesa despesa) {
		
	}
	
	@Override
	public void estornar(Receita receita) {
		
	}
}
