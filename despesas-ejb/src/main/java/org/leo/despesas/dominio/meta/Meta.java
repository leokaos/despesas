package org.leo.despesas.dominio.meta;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;
import java.util.List;

import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.leo.despesas.dominio.movimentacao.Movimentacao;
import org.leo.despesas.infra.Mes;
import org.leo.despesas.infra.ModelEntity;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.rest.MetaDeserializer;

@Entity
@Table(name = "meta", schema = "despesas_db")
@JsonDeserialize(using = MetaDeserializer.class)
public class Meta implements ModelEntity {

	private static final long serialVersionUID = 6313644358726789152L;

	@Id
	@GeneratedValue(generator = "META_ID_SEQ", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "META_ID_SEQ", sequenceName = "despesas_db.meta_id_seq", allocationSize = 1)
	private Long id;

	@Embedded
	private Mes mes;

	private BigDecimal valor;

	@Transient
	private BigDecimal saldo = BigDecimal.ZERO;

	public Meta() {
		super();
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Mes getMes() {
		return mes;
	}

	public void setMes(Mes mes) {
		this.mes = mes;
	}

	public BigDecimal getValor() {
		return valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

	public BigDecimal getSaldo() {
		return saldo;
	}

	public void setSaldo(BigDecimal saldo) {
		this.saldo = saldo;
	}

	public void calcularSaldo(List<Movimentacao> movimentos) {

		BigDecimal total = BigDecimal.ZERO;

		for (Movimentacao movimentacao : movimentos) {
			total = total.add(movimentacao.getValorContabilistico());
		}

		this.saldo = total;
	}

	public BigDecimal getValorDiario() {

		Periodo periodo = this.mes.getPeriodo();

		if (periodo.pertenceAoPeriodo(new Date())) {
			return this.saldo.subtract(valor).divide(new BigDecimal(periodo.getDiasParaTermino()), 2, RoundingMode.HALF_UP);
		}

		return null;
	}

}
