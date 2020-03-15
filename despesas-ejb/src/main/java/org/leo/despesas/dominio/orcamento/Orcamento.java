package org.leo.despesas.dominio.orcamento;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;
import org.leo.despesas.rest.infra.ModelEntity;

@Entity
@Table(name = "orcamento",schema = "despesas_db")
public class Orcamento implements ModelEntity {

	private static final long serialVersionUID = 3125627003466439125L;

	@Id
	@GeneratedValue(generator = "ORCAMENTO_ID_SEQ", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "ORCAMENTO_ID_SEQ", sequenceName = "despesas_db.orcamento_id_seq", allocationSize = 1)
	@Column(name = "id")
	private Long id;

	@Column(name = "DATA_FINAL")
	private Timestamp dataFinal;

	@Column(name = "DATA_INICIAL")
	private Timestamp dataInicial;

	@ManyToOne
	@JoinColumn(name = "tipo_despesa_id")
	private TipoDespesa tipoDespesa;

	@Column(name = "valor")
	private BigDecimal valor;

	@Transient
	private List<Despesa> despesaDoOrcamento;

	@Transient
	private BigDecimal valorConsolidado;

	public Orcamento() {
		super();
	}

	@Override
	public Long getId() {
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

	@JsonIgnore
	public List<Despesa> getDespesaDoOrcamento() {
		return despesaDoOrcamento;
	}

	public void setDespesaDoOrcamento(List<Despesa> despesaDoOrcamento) {
		this.despesaDoOrcamento = despesaDoOrcamento;
	}

	public BigDecimal getValorConsolidado() {
		return valorConsolidado;
	}

	public void setValorConsolidado(BigDecimal valorConsolidado) {
		this.valorConsolidado = valorConsolidado;
	}

	public void consolidar() {
		valorConsolidado = BigDecimal.ZERO;

		for (Despesa despesa : despesaDoOrcamento) {
			valorConsolidado = valorConsolidado.add(despesa.getValor());
		}
	}
}
