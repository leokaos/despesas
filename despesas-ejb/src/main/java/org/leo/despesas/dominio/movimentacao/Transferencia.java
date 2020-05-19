package org.leo.despesas.dominio.movimentacao;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.tipomovimentacao.TipoMovimentacao;

@Entity
@Table(name = "transferencia", schema = "despesas_db")
@PrimaryKeyJoinColumn(name = "id")
public class Transferencia extends Movimentacao {

	private static final long serialVersionUID = 4682865005993932139L;

	@ManyToOne
	@JoinColumn(name = "creditavel_id")
	private Debitavel creditavel;

	@Column(name = "valor_real")
	private BigDecimal valorReal;

	public Transferencia() {
		super();
	}

	public Debitavel getCreditavel() {
		return creditavel;
	}

	public void setCreditavel(Debitavel creditavel) {
		this.creditavel = creditavel;
	}

	public BigDecimal getValorReal() {
		return valorReal;
	}

	public void setValorReal(BigDecimal valorReal) {
		this.valorReal = valorReal;
	}

	public TipoMovimentacao getTipo() {
		TipoMovimentacao tipoMovimentacao = new TipoMovimentacao();
		tipoMovimentacao.setCor("#FFF");
		tipoMovimentacao.setDescricao("Transferência");
		return tipoMovimentacao;
	}

	public void transferir() {

		if (this.debitavel == null || this.creditavel == null) {
			throw new IllegalStateException();
		}

		this.debitavel.transferir(this);
		this.creditavel.transferir(this);
	}

	@Override
	public BigDecimal getValorContabilistico() {
		return BigDecimal.ZERO;
	}

}
