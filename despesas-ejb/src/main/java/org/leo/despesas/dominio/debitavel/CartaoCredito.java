package org.leo.despesas.dominio.debitavel;

import static java.util.Calendar.MONTH;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.infra.DataUtil;

@Entity
@DiscriminatorValue(value = CartaoCredito.CODIGO_TIPO)
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
	private BandeiraCartaoCredito bandeiraCartaoCredito;

	@OneToMany(mappedBy = "cartao", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
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

	public BandeiraCartaoCredito getBandeiraCartaoCredito() {
		return bandeiraCartaoCredito;
	}

	public void setBandeiraCartaoCredito(final BandeiraCartaoCredito bandeiraCartaoCredito) {
		this.bandeiraCartaoCredito = bandeiraCartaoCredito;
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

	public Fatura getFaturaPorData(final Date dataBase) {

		for (final Fatura fatura : faturas) {
			if (fatura.pertenceFatura(dataBase)) {
				return fatura;
			}
		}

		return null;
	}

	@Override
	public void debitar(final Despesa despesa) {

		Fatura faturaPorData = getFaturaPorData(despesa.getVencimento());

		if (faturaPorData == null) {

			faturaPorData = new Fatura(this);

			// Configuracao da data de fechamento
			Date dataFechamento = new Date(despesa.getVencimento().getTime());
			dataFechamento = DataUtil.setDays(dataFechamento, this.diaDeFechamento);

			if (DataUtil.getFragmentInDays(despesa.getVencimento(), MONTH) > diaDeFechamento) {
				dataFechamento = DataUtil.addMonths(dataFechamento, 1);
			}

			faturaPorData.setDataFechamento(dataFechamento);

			// Configuracao da data de vencimento
			Date dataVencimento = new Date(dataFechamento.getTime());
			dataVencimento = DataUtil.setDays(dataVencimento, this.diaDeVencimento);

			if (diaDeFechamento > diaDeVencimento) {
				dataVencimento = DataUtil.addMonths(dataVencimento, 1);
			}

			faturaPorData.setDataVencimento(dataVencimento);

			faturas.add(faturaPorData);
		}

		faturaPorData.getDespesas().add(despesa);

		setLimiteAtual(getLimiteAtual().subtract(despesa.getValor()));
	}

	@Override
	public void creditar(final Receita receita) {
		setLimiteAtual(getLimiteAtual().add(receita.getValor()));
	}

	@Override
	public Despesa consolidar(final Despesa despesa) {

		final Fatura fatura = getFaturaPorData(despesa.getVencimento());

		if (fatura.getId() != null) {
			despesa.setFatura(fatura);
		}

		return despesa;
	}

	@Override
	public void transferir(final Transferencia transferencia) {

		if (transferencia.getCreditavel().equals(this)) {
			this.limiteAtual = getLimiteAtual().add(transferencia.getValor());
		} else if (transferencia.getDebitavel().equals(this)) {
			this.limiteAtual = getLimiteAtual().subtract(transferencia.getValor());
		} else {
			throw new IllegalArgumentException();
		}
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

}
