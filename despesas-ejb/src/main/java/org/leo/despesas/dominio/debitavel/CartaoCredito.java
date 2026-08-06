package org.leo.despesas.dominio.debitavel;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.leo.despesas.dominio.alerta.TipoPeriodicidade;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.rest.DebitavelSerializerVisitorImpl;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "cartao", schema = "despesas_db")
public class CartaoCredito extends Debitavel {

	private static final long serialVersionUID = -1135677579840442143L;

	public static final String CODIGO_TIPO = "CARTAO";

	@Column(name = "limite")
	private BigDecimal limite;

	@Column(name = "limite_atual")
	private BigDecimal limiteAtual;

	@Column(name = "diaDeVencimento")
	private Integer diaDeVencimento;

	@Column(name = "diaDeFechamento")
	private Integer diaDeFechamento;

	@Enumerated(EnumType.STRING)
	@Column(name = "bandeiraCartaoCredito")
	private BandeiraCartaoCredito bandeira;

	@OneToMany(mappedBy = "cartao", cascade = { CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE }, fetch = FetchType.EAGER)
	private Set<Fatura> faturas;

	public CartaoCredito() {
		super();
		this.faturas = new HashSet<Fatura>();
		setTipo(CODIGO_TIPO);
	}

	public BigDecimal getLimite() {
		return limite;
	}

	public void setLimite(final BigDecimal limite) {
		this.limite = limite;
	}

	public Integer getDiaDeVencimento() {
		return diaDeVencimento;
	}

	public void setDiaDeVencimento(final Integer diaDeVencimento) {
		this.diaDeVencimento = diaDeVencimento;
	}

	public Integer getDiaDeFechamento() {
		return diaDeFechamento;
	}

	public void setDiaDeFechamento(final Integer diaDeFechamento) {
		this.diaDeFechamento = diaDeFechamento;
	}

	public BandeiraCartaoCredito getBandeira() {
		return bandeira;
	}

	public void setBandeira(BandeiraCartaoCredito bandeira) {
		this.bandeira = bandeira;
	}

	public BigDecimal getLimiteAtual() {
		return limiteAtual;
	}

	public void setLimiteAtual(final BigDecimal limiteAtual) {
		this.limiteAtual = limiteAtual;
	}

	public String getTipo() {
		return CODIGO_TIPO;
	}

	@JsonIgnore
	public Set<Fatura> getFaturas() {
		return faturas;
	}

	public void setFaturas(final Set<Fatura> faturas) {
		this.faturas = faturas;
	}

	public Fatura getFaturaPorData(LocalDate dataBase) {

		for (final Fatura fatura : faturas) {
			if (fatura.pertenceFatura(dataBase)) {
				return fatura;
			}
		}

		return null;
	}

	public LocalDate getDataProximaFatura() {
		return TipoPeriodicidade.DIA_UTIL.getCalculator().apply(diaDeVencimento);
	}

	@Override
	public void debitar(final Despesa despesa) {

		Fatura faturaPorData = getFaturaPorData(despesa.getVencimento());

		if (faturaPorData == null) {

			faturaPorData = new Fatura(this);

			LocalDate dataFechamento = despesa.getVencimento().withDayOfMonth(this.diaDeFechamento);

			if (dataFechamento.isBefore(despesa.getVencimento()) || dataFechamento.isEqual(despesa.getVencimento())) {
				dataFechamento = dataFechamento.plusMonths(1);
			}

			LocalDate dataVencimento = dataFechamento.withDayOfMonth(this.diaDeVencimento);

			if (this.diaDeFechamento > this.diaDeVencimento) {
				dataVencimento = dataVencimento.plusMonths(1);
			}

			faturaPorData.setDataVencimento(dataVencimento);
			faturaPorData.setDataFechamento(dataFechamento);

			faturas.add(faturaPorData);
		}

		if (faturaPorData.isPaga()) {
			throw new IllegalArgumentException("Fatura já está paga");
		}

		faturaPorData.getDespesas().add(despesa);
		despesa.setFatura(faturaPorData);
	}

	@Override
	public void creditar(final Receita receita) {
		setLimiteAtual(getLimiteAtual().add(receita.getValor()));
	}

	@Override
	public Despesa consolidar(final Despesa despesa) {

		Fatura faturaPorData = getFaturaPorData(despesa.getVencimento());

		if (faturaPorData != null) {
			despesa.setFatura(faturaPorData);
		}

		return despesa;
	}

	@Override
	public void transferir(final Transferencia transferencia) {

	}

	@Override
	public void accept(DebitavelSerializerVisitorImpl visitor) {
		visitor.visit(this);
	}

	@Override
	public BigDecimal getSaldo() {

		BigDecimal total = this.limite;

		for (Fatura fatura : faturas) {
			if (!fatura.isPaga()) {
				total = total.subtract(fatura.getValorFatura());
			}
		}

		return total;
	}

	@Override
	public void estornar(Despesa despesa) {

	}

	@Override
	public void estornar(Receita receita) {

	}

	@Override
	public void estornar(Transferencia transferencia) {

	}

}
