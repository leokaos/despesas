package org.leo.despesas.dominio.meta;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;

import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.rest.infra.ModelEntity;

public class Meta implements ModelEntity {

	private static final long serialVersionUID = 6313644358726789152L;

	private Long id;

	private String descricao;

	private BigDecimal valorDaMeta;

	private BigDecimal valorAtual;

	private Date dataInicio;

	private Date dataFim;

	public Meta() {
		super();
	}

	@Override
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public BigDecimal getValorDaMeta() {
		return valorDaMeta;
	}

	public void setValorDaMeta(BigDecimal valorDaMeta) {
		this.valorDaMeta = valorDaMeta;
	}

	public BigDecimal getValorAtual() {
		return valorAtual;
	}

	public void setValorAtual(BigDecimal valorAtual) {
		this.valorAtual = valorAtual;
	}

	public Date getDataInicio() {
		return dataInicio;
	}

	public void setDataInicio(Date dataInicio) {
		this.dataInicio = dataInicio;
	}

	public Date getDataFim() {
		return dataFim;
	}

	public void setDataFim(Date dataFim) {
		this.dataFim = dataFim;
	}

	public BigDecimal getPorcentagemConcluida() {
		return valorAtual.divide(valorDaMeta,RoundingMode.HALF_EVEN).multiply(new BigDecimal("100.00"));
	}

	public Receita associarReceitaParaMeta(Receita receita,BigDecimal valor) {
		return receita;
	}

	public Receita associarReceitaParaMeta(Receita receita) {
		return associarReceitaParaMeta(receita,receita.getValor());
	}

}
