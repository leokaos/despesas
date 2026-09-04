package org.leo.despesas.dominio.debitavel;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.infra.ModelEntity;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.infra.util.DataUtil;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "fatura", schema = "despesas_db")
@Getter
@Setter
@NoArgsConstructor
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
	private LocalDate dataVencimento;

	@Column(name = "data_fechamento")
	private LocalDate dataFechamento;

	@OneToMany(mappedBy = "fatura", fetch = FetchType.EAGER)
	private Set<Despesa> despesas = new HashSet<>();

	@Column(name = "paga")
	private boolean paga;

	public Fatura(final CartaoCredito cartao) {
		this();

		this.cartao = cartao;
	}

	public BigDecimal getValorFatura() {
		BigDecimal total = BigDecimal.ZERO;

		for (final Despesa despesa : despesas) {
			total = total.add(despesa.getValor() == null ? BigDecimal.ZERO : despesa.getValor());
		}

		return total;
	}

	public boolean pertenceFatura(final LocalDate dataBase) {
		return getPeriodo().pertenceAoPeriodo(dataBase);
	}

	private Periodo getPeriodo() {
		return new Periodo(dataFechamento.minusMonths(1), dataFechamento);
	}

	public Transferencia pagar(final Conta conta) throws DespesasException {

		if (!conta.getMoeda().equals(this.getCartao().getMoeda())) {
			throw new DespesasException("Conta com moeda diferente do cartao!");
		}

		final Transferencia transferencia = new Transferencia();

		transferencia.setDescricao("Pagamento fatura " + dataVencimento.format(DateTimeFormatter.ofPattern("MM/yyyy")));
		transferencia.setCreditavel(getCartao());
		transferencia.setDebitavel(conta);
		transferencia.setPagamento(LocalDate.now(DataUtil.CLOCK));
		transferencia.setValor(getValorFatura());
		transferencia.setValorReal(getValorFatura());
		transferencia.setVencimento(LocalDate.now(DataUtil.CLOCK));
		transferencia.setMoeda(conta.getMoeda());

		setPaga(true);

		return transferencia;
	}

	public boolean hasDespesas() {
		return !this.despesas.isEmpty();
	}
}
