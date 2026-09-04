package org.leo.despesas.dominio.servicotransferencia;

import java.math.BigDecimal;
import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.leo.despesas.infra.ModelEntity;
import org.leo.despesas.infra.Moeda;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "cotacao", schema = "despesas_db")
@Getter
@Setter
@NoArgsConstructor
public class Cotacao implements ModelEntity {

	private static final long serialVersionUID = 8325205388002175958L;

	@Id
	@GeneratedValue(generator = "COTACAO_ID_SEQ", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "COTACAO_ID_SEQ", sequenceName = "despesas_db.cotacao_id_seq", allocationSize = 1)
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
	private LocalDate data;

}
