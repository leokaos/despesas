package org.leo.despesas.dominio.orcamento;

import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;

@Entity
@Table(name = "orcamento", schema = "despesas_db")
public class Orcamento {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private long id;

	@Column(name = "DATA_FINAL")
	private Timestamp dataFinal;

	@Column(name = "DATA_INICIAL")
	private Timestamp dataInicial;

	@ManyToOne
	@JoinColumn(name = "tipo_despesa_id")
	private TipoDespesa tipoDespesa;

	private BigDecimal valor;

	public Orcamento() {
		super();
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Timestamp getDataFinal() {
		return this.dataFinal;
	}

	public void setDataFinal(Timestamp dataFinal) {
		this.dataFinal = dataFinal;
	}

	public Timestamp getDataInicial() {
		return this.dataInicial;
	}

	public void setDataInicial(Timestamp dataInicial) {
		this.dataInicial = dataInicial;
	}

	public TipoDespesa getTipoDespesa() {
		return tipoDespesa;
	}

	public void setTipoDespesa(TipoDespesa tipoDespesa) {
		this.tipoDespesa = tipoDespesa;
	}

	public BigDecimal getValor() {
		return this.valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

}