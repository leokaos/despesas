package org.leo.despesas.dominio.movimentacao;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.debitavel.DebitavelDeserializer;

@Entity
@Table(name = "movimentacao", schema = "despesas_db")
@DiscriminatorColumn(name = "tipo")
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class Movimentacao {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "descricao")
	private String descricao;

	@Column(name = "valor")
	private BigDecimal valor;

	@Column(name = "vencimento")
	@Temporal(TemporalType.TIMESTAMP)
	private Date vencimento;

	@Column(name = "pagamento")
	@Temporal(TemporalType.TIMESTAMP)
	private Date pagamento;

	@ManyToOne
	@JoinColumn(name = "debitavel_id")
	protected Debitavel debitavel;

	public Movimentacao() {
		super();
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public BigDecimal getValor() {
		return valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

	public Date getVencimento() {
		return vencimento;
	}

	public void setVencimento(Date vencimento) {
		this.vencimento = vencimento;
	}

	public Debitavel getDebitavel() {
		return debitavel;
	}

	@JsonDeserialize(using = DebitavelDeserializer.class)
	public void setDebitavel(Debitavel debitavel) {
		this.debitavel = debitavel;
	}

	public Date getPagamento() {
		return pagamento;
	}

	public void setPagamento(Date pagamento) {
		this.pagamento = pagamento;
	}

	protected void fechar() {
		setPagamento(new Date());
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(valor).append(descricao).append(debitavel).append(vencimento).toHashCode();
	}

	@Override
	public boolean equals(Object o) {

		if (o instanceof Movimentacao) {

			Movimentacao o1 = (Movimentacao) o;

			EqualsBuilder equalsBuilder = new EqualsBuilder();
			equalsBuilder.append(valor, o1.valor);
			equalsBuilder.append(descricao, o1.descricao);
			equalsBuilder.append(debitavel, o1.debitavel);
			equalsBuilder.append(vencimento, o1.vencimento);

			return equalsBuilder.isEquals();

		} else {
			return false;
		}
	}
}