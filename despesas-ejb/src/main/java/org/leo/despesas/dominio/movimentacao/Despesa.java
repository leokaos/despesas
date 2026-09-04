package org.leo.despesas.dominio.movimentacao;

import java.math.BigDecimal;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.search.annotations.Indexed;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "despesa", schema = "despesas_db")
@PrimaryKeyJoinColumn(name = "id")
@Indexed
@Getter
@Setter
@NoArgsConstructor
public class Despesa extends Movimentacao {

	private static final long serialVersionUID = -832942623220660512L;

	@Column(name = "paga")
	private boolean paga;

	@ManyToOne
	@JoinColumn(name = "tipo_despesa_id")
	private TipoDespesa tipo;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "fatura_id", nullable = true)
	@JsonIgnore
	private Fatura fatura;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "notificacao_id", nullable = true)
	private Notificacao notificacao;

	public void pagar() {
		debitavel.debitar(this);

		setPaga(true);
		fechar();
	}

	public Despesa consolidar() {
		return debitavel.consolidar(this);
	}

	@Override
	@JsonIgnore
	public BigDecimal getValorContabilistico() {
		return this.getValor().multiply(new BigDecimal(-1));
	}
}
