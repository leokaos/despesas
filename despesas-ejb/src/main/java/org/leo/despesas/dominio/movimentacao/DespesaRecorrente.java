package org.leo.despesas.dominio.movimentacao;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;
import org.leo.despesas.rest.infra.ModelEntity;

public class DespesaRecorrente implements ModelEntity {

	private static final long serialVersionUID = -978563326166640845L;

	private static final String FORMAT_DESCRICAO = "{0} - {1}";
	private static final DateFormat FORMAT_DATE = new SimpleDateFormat("dd/MM/yyyy");

	private Long id;

	private DiaDoMes diaDoMes;

	private BigDecimal valor;

	private TipoDespesa tipo;

	private String descricao;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public DiaDoMes getDiaDoMes() {
		return diaDoMes;
	}

	public void setDiaDoMes(DiaDoMes diaDoMes) {
		this.diaDoMes = diaDoMes;
	}

	public BigDecimal getValor() {
		return valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

	public TipoDespesa getTipo() {
		return tipo;
	}

	public void setTipo(TipoDespesa tipo) {
		this.tipo = tipo;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public Despesa gerarDespesa(Date vencimento) {

		Date proximoVencimento = diaDoMes.getNext(vencimento);
		String descricaoDespesa = MessageFormat.format(FORMAT_DESCRICAO, descricao, FORMAT_DATE.format(proximoVencimento));

		Despesa despesa = new Despesa();

		despesa.setTipo(tipo);
		despesa.setValor(valor);
		despesa.setVencimento(proximoVencimento);
		despesa.setDescricao(descricaoDespesa);

		return despesa;
	}

}
