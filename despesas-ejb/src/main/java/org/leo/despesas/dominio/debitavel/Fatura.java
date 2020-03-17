package org.leo.despesas.dominio.debitavel;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.infra.ModelEntity;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.util.DataUtil;

@Entity
@Table(name = "fatura",schema = "despesas_db")
public class Fatura implements ModelEntity {

	private static final long serialVersionUID = -4047341391900604495L;

	@Id
	@GeneratedValue(generator = "FATURA_ID_SEQ", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "FATURA_ID_SEQ", sequenceName = "despesas_db.fatura_id_seq", allocationSize = 1)
	private Long id;

	@ManyToOne
	@JoinColumn(name = "cartao_id")
	private CartaoCredito cartao;

	@Column(name = "data_vencimento")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dataVencimento;

	@Column(name = "data_fechamento")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dataFechamento;

	@OneToMany(mappedBy = "fatura",fetch = FetchType.EAGER)
	private Set<Despesa> despesas;

	@Column(name = "paga")
	private boolean paga;

	public Fatura() {
		super();

		this.despesas = new HashSet<Despesa>();
	}

	public Fatura(final CartaoCredito cartao) {
		this();

		this.cartao = cartao;
	}

	@Override
	public Long getId() {
		return id;
	}

	public void setId(final Long id) {
		this.id = id;
	}

	public CartaoCredito getCartao() {
		return cartao;
	}

	public void setCartao(final CartaoCredito cartao) {
		this.cartao = cartao;
	}

	public Date getDataVencimento() {
		return dataVencimento;
	}

	public void setDataVencimento(final Date dataVencimento) {
		this.dataVencimento = dataVencimento;
	}

	public Date getDataFechamento() {
		return dataFechamento;
	}

	public void setDataFechamento(final Date dataFechamento) {
		this.dataFechamento = dataFechamento;
	}

	public Set<Despesa> getDespesas() {
		return despesas;
	}

	public void setDespesas(final Set<Despesa> despesas) {
		this.despesas = despesas;
	}

	public boolean isPaga() {
		return paga;
	}

	public void setPaga(final boolean paga) {
		this.paga = paga;
	}

	public BigDecimal getValorFatura() {
		BigDecimal total = BigDecimal.ZERO;

		for (final Despesa despesa : despesas) {
			total = total.add(despesa.getValor());
		}

		return total;
	}

	public boolean pertenceFatura(final Date dataBase) {
		return getPeriodo().pertenceAoPeriodo(dataBase);
	}

	private Periodo getPeriodo() {
		return new Periodo(DataUtil.addMonths(dataFechamento,-1),dataFechamento);
	}

	public Transferencia pagar(final Conta conta) {

		final Transferencia transferencia = new Transferencia();

		transferencia.setDescricao("Pagamento fatura " + DataUtil.formatarMes(dataVencimento));
		transferencia.setCreditavel(getCartao());
		transferencia.setDebitavel(conta);
		transferencia.setPagamento(new Date());
		transferencia.setValor(getValorFatura());
		transferencia.setVencimento(new Date());

		cartao.transferir(transferencia);
		conta.transferir(transferencia);

		setPaga(true);

		return transferencia;
	}
}
