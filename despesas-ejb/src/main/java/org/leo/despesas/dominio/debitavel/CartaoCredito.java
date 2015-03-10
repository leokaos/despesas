package org.leo.despesas.dominio.debitavel;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.infra.DataUtil;

@Entity
@DiscriminatorValue(value = "CONTA")
@Table(name = "cartao", schema = "despesas_db")
public class CartaoCredito extends Debitavel {

	@Column(name = "limite")
	private BigDecimal limite;

	@Column(name = "diaDeVencimento")
	private Integer diaDeVencimento;

	@Column(name = "diaDeFechamento")
	private Integer diaDeFechamento;

	@Enumerated(EnumType.STRING)
	@Column(name = "bandeiraCartaoCredito")
	private BandeiraCartaoCredito bandeiraCartaoCredito;

	@Transient
	private List<Fatura> faturas;

	public CartaoCredito() {
		super();

		this.faturas = new ArrayList<Fatura>();
	}

	public BigDecimal getLimite() {
		return limite;
	}

	public void setLimite(BigDecimal limite) {
		this.limite = limite;
	}

	public Integer getDiaDeVencimento() {
		return diaDeVencimento;
	}

	public void setDiaDeVencimento(Integer diaDeVencimento) {
		this.diaDeVencimento = diaDeVencimento;
	}

	public Integer getDiaDeFechamento() {
		return diaDeFechamento;
	}

	public void setDiaDeFechamento(Integer diaDeFechamento) {
		this.diaDeFechamento = diaDeFechamento;
	}

	public BandeiraCartaoCredito getBandeiraCartaoCredito() {
		return bandeiraCartaoCredito;
	}

	public void setBandeiraCartaoCredito(BandeiraCartaoCredito bandeiraCartaoCredito) {
		this.bandeiraCartaoCredito = bandeiraCartaoCredito;
	}

	public List<Fatura> getFaturas() {
		return faturas;
	}

	public void setFaturas(List<Fatura> faturas) {
		this.faturas = faturas;
	}

	public Fatura getFaturaPorData(Date dataBase) {

		for (Fatura fatura : faturas) {
			if (fatura.pertenceFatura(dataBase)) {
				return fatura;
			}
		}

		return null;
	}

	@Override
	public void debitar(Despesa despesa) {

		Fatura faturaPorData = getFaturaPorData(despesa.getVencimento());

		if (faturaPorData == null) {

			faturaPorData = new Fatura(this);

			// Configuracao da data de fechamento
			Date dataFechamento = new Date(despesa.getVencimento().getTime());
			dataFechamento = DataUtil.setDays(dataFechamento, this.diaDeFechamento);

			faturaPorData.setDataFechamento(dataFechamento);

			// Configuracao da data de vencimento
			Date dataVencimento = new Date(despesa.getVencimento().getTime());
			dataVencimento = DataUtil.setDays(dataVencimento, this.diaDeVencimento);

			if (diaDeFechamento > diaDeVencimento) {
				dataVencimento = DataUtil.addMonths(dataVencimento, 1);
			}

			faturaPorData.setDataVencimento(dataVencimento);
		}

		faturaPorData.getDespesas().add(despesa);

		faturas.add(faturaPorData);
	}

	@Override
	public void creditar(Receita receita) {

	}

}
