package org.leo.despesas.dominio.alerta;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.infra.ModelEntity;
import org.leo.despesas.infra.alerta.AlertaProcessorVisitor;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

@Entity
@Table(name = "alerta", schema = "despesas_db")
@Inheritance(strategy = InheritanceType.JOINED)
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME, include = JsonTypeInfo.As.EXISTING_PROPERTY, property = "tipo", visible = true)
//@formatter:off
@JsonSubTypes({ 
	@JsonSubTypes.Type(value = AlertaDespesaRecorrente.class, name = "DESPESA_RECORRENTE"), 
	@JsonSubTypes.Type(value = AlertaPagamentoFaturaCartao.class, name = "FATURA_CARTAO_CREDITO"),
	@JsonSubTypes.Type(value = AlertaLimitePagamentoDivida.class, name = "VALOR_LIMITE_DIVIDA")
})
//@formatter:on
public abstract class Alerta implements ModelEntity {

	private static final long serialVersionUID = 3937060574469790488L;

	@Id
	@GeneratedValue(generator = "ALERTA_ID_SEQ", strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(name = "ALERTA_ID_SEQ", sequenceName = "despesas_db.alerta_id_seq", allocationSize = 1)
	private Long id;

	@Column(name = "tipo")
	@Enumerated(EnumType.STRING)
	private TipoAlerta tipo;

	@Column(name = "dias_antes_de_aviso")
	protected int diasAntesDeAviso;

	@JsonIgnore
	@OneToMany(mappedBy = "alerta", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<Notificacao> notificacoes = new ArrayList<>();

	public Alerta() {
		super();
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public TipoAlerta getTipo() {
		return tipo;
	}

	public void setTipo(TipoAlerta tipo) {
		this.tipo = tipo;
	}

	public int getDiasAntesDeAviso() {
		return diasAntesDeAviso;
	}

	public void setDiasAntesDeAviso(int diasAntesDeAviso) {
		this.diasAntesDeAviso = diasAntesDeAviso;
	}

	public List<Notificacao> getNotificacoes() {
		return notificacoes;
	}

	public void setNotificacoes(List<Notificacao> notificacoes) {
		this.notificacoes = notificacoes;
	}

	public abstract Notificacao gerarNotificacao();

	public abstract String getDescricao();

	public abstract void accept(AlertaProcessorVisitor visitor);

}
