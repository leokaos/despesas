package org.leo.despesas.dominio.movimentacao;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.leo.despesas.dominio.debitavel.Investimento;
import org.leo.despesas.dominio.tipomovimentacao.TipoReceita;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "receita", schema = "despesas_db")
@PrimaryKeyJoinColumn(name = "id")
@Getter
@Setter
@NoArgsConstructor
public class Receita extends Movimentacao {

	private static final long serialVersionUID = -2809658495598686884L;

	@Column(name = "depositado")
	private boolean depositado;

	@ManyToOne
	@JoinColumn(name = "tipo_receita_id")
	private TipoReceita tipo;

	@ManyToOne
	@JoinColumn(name = "investimento_id")
	private Investimento investimento;

	@Column(name = "compromissada")
	private boolean compromissada;

	public void depositar() {
		this.debitavel.creditar(this);

		setDepositado(true);
		fechar();
	}

	@Override
	@JsonIgnore
	public BigDecimal getValorContabilistico() {
		return this.compromissada ? BigDecimal.ZERO : this.getValor();
	}

}
