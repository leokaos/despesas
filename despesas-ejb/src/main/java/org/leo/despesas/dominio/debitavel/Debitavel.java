package org.leo.despesas.dominio.debitavel;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.dominio.servicotransferencia.Moeda;
import org.leo.despesas.rest.infra.ModelEntity;

@Entity
@DiscriminatorColumn(name = "tipo")
@Table(name = "debitavel", schema = "despesas_db")
@Inheritance(strategy = InheritanceType.JOINED)
@JsonDeserialize(using = DebitavelDeserializer.class)
public abstract class Debitavel implements ModelEntity {

	private static final long serialVersionUID = -2096306756580686432L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "descricao")
	private String descricao;

	@Column(name = "cor")
	private String cor;

	@Column(name = "tipo")
	private String tipo;

	@Column(name = "moeda")
	@Enumerated(EnumType.STRING)
	private Moeda moeda;

	public Debitavel() {
		super();
	}

	@Override
	public Long getId() {
		return id;
	}

	public void setId(final Long id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(final String descricao) {
		this.descricao = descricao;
	}

	public String getCor() {
		return cor;
	}

	public void setCor(final String cor) {
		this.cor = cor;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public Moeda getMoeda() {
		return moeda;
	}

	public void setMoeda(Moeda moeda) {
		this.moeda = moeda;
	}

	public abstract void debitar(Despesa despesa);

	public abstract void creditar(Receita receita);

	public abstract void transferir(Transferencia transferencia);

	public abstract Despesa consolidar(Despesa despesa);

	public abstract void accept(DebitavelSerializerVisitorImpl visitor);

	public abstract BigDecimal getSaldo();
}
