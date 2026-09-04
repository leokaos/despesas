package org.leo.despesas.dominio.orcamento;

import java.math.BigDecimal;
import java.time.LocalDate;
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

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;
import org.leo.despesas.infra.ModelEntity;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "orcamento", schema = "despesas_db")
@Getter
@Setter
@NoArgsConstructor
public class Orcamento implements ModelEntity {

	private static final long serialVersionUID = 3125627003466439125L;

	@Id
	@GeneratedValue(generator = "ORCAMENTO_ID_SEQ", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "ORCAMENTO_ID_SEQ", sequenceName = "despesas_db.orcamento_id_seq", allocationSize = 1)
	@Column(name = "id")
	private Long id;

	@Column(name = "DATA_FINAL")
	private LocalDate dataFinal;

	@Column(name = "DATA_INICIAL")
	private LocalDate dataInicial;

	@ManyToOne
	@JoinColumn(name = "tipo_despesa_id")
	private TipoDespesa tipoDespesa;

	@Column(name = "valor")
	private BigDecimal valor;

	@Transient
	@JsonIgnore
	private List<Despesa> despesaDoOrcamento;

	@Transient
	private BigDecimal valorConsolidado;

	public void consolidar() {
		valorConsolidado = BigDecimal.ZERO;

		for (Despesa despesa : despesaDoOrcamento) {
			valorConsolidado = valorConsolidado.add(despesa.getValor());
		}
	}
}
