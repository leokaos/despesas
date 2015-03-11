package org.leo.despesas.dominio.debitavel;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.infra.DataUtil;
import org.leo.despesas.infra.Periodo;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "fatura", schema = "despesas_db")
public class Fatura {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne
	@JoinColumn(name = "cartao_id")
	@JsonBackReference
	private CartaoCredito cartao;

	@Column(name = "data_vencimento")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dataVencimento;

	@Column(name = "data_fechamento")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dataFechamento;

	@OneToMany(mappedBy = "fatura")
	@JsonManagedReference
	private List<Despesa> despesas;

	public Fatura() {
		super();

		this.despesas = new ArrayList<Despesa>();
	}

	public Fatura(CartaoCredito cartao) {
		this();

		this.cartao = cartao;
	}

	public CartaoCredito getCartao() {
		return cartao;
	}

	public void setCartao(CartaoCredito cartao) {
		this.cartao = cartao;
	}

	public Date getDataVencimento() {
		return dataVencimento;
	}

	public void setDataVencimento(Date dataVencimento) {
		this.dataVencimento = dataVencimento;
	}

	public Date getDataFechamento() {
		return dataFechamento;
	}

	public void setDataFechamento(Date dataFechamento) {
		this.dataFechamento = dataFechamento;
	}

	public List<Despesa> getDespesas() {
		return despesas;
	}

	public void setDespesas(List<Despesa> despesas) {
		this.despesas = despesas;
	}

	public BigDecimal getValorFatura() {
		BigDecimal total = BigDecimal.ZERO;

		for (Despesa despesa : despesas) {
			total = total.add(despesa.getValor());
		}

		return total;
	}

	public boolean pertenceFatura(Date dataBase) {
		return getPeriodoVigencia().pertenceAoPeriodo(dataBase);
	}

	private Periodo getPeriodoVigencia() {
		return new Periodo(DataUtil.addDays(dataFechamento, -1), dataFechamento);
	}
}
