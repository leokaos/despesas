package org.leo.despesas.dominio.movimentacao;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.hibernate.search.annotations.Analyze;
import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.Index;
import org.hibernate.search.annotations.Indexed;
import org.hibernate.search.annotations.Store;
import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.infra.ModelEntity;
import org.leo.despesas.infra.Moeda;
import org.leo.despesas.rest.DebitavelDeserializer;

@Entity
@Table(name = "movimentacao", schema = "despesas_db")
@Inheritance(strategy = InheritanceType.JOINED)
@Indexed
public abstract class Movimentacao implements ModelEntity {

	private static final long serialVersionUID = 7650797422719540384L;

	@Id
	@GeneratedValue(generator = "MOVIMENTACAO_ID_SEQ", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "MOVIMENTACAO_ID_SEQ", sequenceName = "despesas_db.movimentacao_id_seq", allocationSize = 1)
	private Long id;

	@Column(name = "descricao")
	@Field(index = Index.YES, analyze = Analyze.YES, store = Store.NO)
	private String descricao;

	@Column(name = "valor")
	private BigDecimal valor;

	@Column(name = "vencimento")
	@Temporal(TemporalType.DATE)
	private Date vencimento;

	@Column(name = "pagamento")
	@Temporal(TemporalType.DATE)
	private Date pagamento;

	@ManyToOne
	@JoinColumn(name = "debitavel_id")
	protected Debitavel debitavel;

	@Column(name = "moeda")
	@Enumerated(EnumType.STRING)
	private Moeda moeda;

	public Movimentacao() {
		super();
	}

	@Override
	public Long getId() {
		return id;
	}

	public void setId(final Long id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(final String descricao) {
		this.descricao = descricao;
	}

	public BigDecimal getValor() {
		return valor;
	}

	public void setValor(final BigDecimal valor) {
		this.valor = valor;
	}

	public Date getVencimento() {
		return vencimento;
	}

	public void setVencimento(final Date vencimento) {
		this.vencimento = vencimento;
	}

	public Debitavel getDebitavel() {
		return debitavel;
	}

	@JsonDeserialize(using = DebitavelDeserializer.class)
	public void setDebitavel(final Debitavel debitavel) {
		this.debitavel = debitavel;
	}

	public Date getPagamento() {
		return pagamento;
	}

	public void setPagamento(final Date pagamento) {
		this.pagamento = pagamento;
	}

	protected void fechar() {
		setPagamento(new Date());
	}

	public Moeda getMoeda() {
		return moeda;
	}

	public void setMoeda(Moeda moeda) {
		this.moeda = moeda;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(valor).append(descricao).append(debitavel).append(vencimento).toHashCode();
	}

	@Override
	public boolean equals(final Object o) {

		if (o instanceof Movimentacao) {

			final Movimentacao o1 = (Movimentacao) o;

			final EqualsBuilder equalsBuilder = new EqualsBuilder();
			equalsBuilder.append(valor, o1.valor);
			equalsBuilder.append(descricao, o1.descricao);
			equalsBuilder.append(debitavel, o1.debitavel);
			equalsBuilder.append(vencimento, o1.vencimento);

			return equalsBuilder.isEquals();

		} else {
			return false;
		}
	}

	public abstract BigDecimal getValorContabilistico();
}
