package org.leo.despesas.dominio.servicotransferencia;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.leo.despesas.rest.infra.ModelEntity;

@Entity
@Table(name = "cotacao", schema = "despesas_db")
public class Cotacao implements ModelEntity {

	private static final long serialVersionUID = 8325205388002175958L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;

	@Column(name = "ORIGEM")
	@Enumerated(EnumType.STRING)
	private Moeda origem;

	@Column(name = "DESTINO")
	@Enumerated(EnumType.STRING)
	private Moeda destino;

	@Column(name = "TAXA")
	private BigDecimal taxa;

	@Column(name = "DATA")
	@Temporal(TemporalType.TIMESTAMP)
	private Date data;

	public Cotacao() {
		super();
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Moeda getOrigem() {
		return origem;
	}

	public void setOrigem(Moeda origem) {
		this.origem = origem;
	}

	public Moeda getDestino() {
		return destino;
	}

	public void setDestino(Moeda destino) {
		this.destino = destino;
	}

	public BigDecimal getTaxa() {
		return taxa;
	}

	public void setTaxa(BigDecimal taxa) {
		this.taxa = taxa;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

}
