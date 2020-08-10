package org.leo.despesas.dominio.debitavel;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.rest.DebitavelSerializerVisitorImpl;

@Entity
@Table(name = "divida", schema = "despesas_db")
public class Divida extends Debitavel {

	private static final long serialVersionUID = -6519041279325299586L;

	public static final String CODIGO_TIPO = "DIVIDA";

	@Column(name = "valor_total")
	private BigDecimal valorTotal;

	@Column(name = "periodiciodade")
	@Enumerated(EnumType.STRING)
	private Periodicidade periodicidade;

	@Column(name = "data_inicio")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dataInicio;

	@OneToMany(mappedBy = "creditavel", fetch = FetchType.EAGER)
	private Set<Transferencia> pagamentos;

	public Divida() {
		super();
		setTipo(CODIGO_TIPO);
	}

	public BigDecimal getValorTotal() {
		return valorTotal;
	}

	public void setValorTotal(BigDecimal valorTotal) {
		this.valorTotal = valorTotal;
	}

	public Periodicidade getPeriodicidade() {
		return periodicidade;
	}

	public void setPeriodicidade(Periodicidade periodicidade) {
		this.periodicidade = periodicidade;
	}

	public Date getDataInicio() {
		return dataInicio;
	}

	public void setDataInicio(Date dataInicio) {
		this.dataInicio = dataInicio;
	}

	@JsonIgnore
	public Set<Transferencia> getPagamentos() {
		return pagamentos;
	}

	public void setPagamentos(Set<Transferencia> pagamentos) {
		this.pagamentos = pagamentos;
	}

	public BigDecimal getValorRestante() {

		BigDecimal parcial = BigDecimal.ZERO;

		if (pagamentos == null || pagamentos.isEmpty()) {
			return valorTotal;
		}

		for (Transferencia transferencia : pagamentos) {
			parcial = parcial.add(transferencia.getValor());
		}

		return valorTotal.subtract(parcial);
	}

	@Override
	public void debitar(Despesa despesa) {

	}

	@Override
	public void creditar(Receita receita) {

	}

	@Override
	public void transferir(Transferencia transferencia) {

	}

	@Override
	public Despesa consolidar(Despesa despesa) {
		return despesa;
	}

	@Override
	public void accept(DebitavelSerializerVisitorImpl visitor) {
		visitor.visit(this);
	}

	@Override
	public BigDecimal getSaldo() {
		return getValorRestante().multiply(new BigDecimal(-1));
	}
	
	@Override
	public void estornar(Despesa despesa) {
		
	}

}
