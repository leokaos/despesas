package org.leo.despesas.dominio.servicotransferencia;

import static java.math.RoundingMode.HALF_DOWN;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.leo.despesas.rest.infra.ModelEntity;

@Entity
@Table(name = "servico_transferencia", schema = "despesas_db")
public class ServicoTransferencia implements ModelEntity {

	private static final long serialVersionUID = -8754012359474676770L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(name = "NOME")
	private String nome;

	@Column(name = "SPRED")
	private BigDecimal spred;

	@Column(name = "TAXAS")
	private BigDecimal taxas;

	public ServicoTransferencia() {
		super();
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public BigDecimal getSpred() {
		return spred;
	}

	public void setSpred(BigDecimal spred) {
		this.spred = spred;
	}

	public BigDecimal getTaxas() {
		return taxas;
	}

	public void setTaxas(BigDecimal taxas) {
		this.taxas = taxas;
	}

	public double calcularValorParaTransferencia(Cotacao cotacao, BigDecimal spot, Porcentagem iof, BigDecimal valor) {
		
		BigDecimal cotacaoSemSpot = cotacao.getTaxa().subtract(spot);

		BigDecimal cotacaoDepoisSpred = cotacaoSemSpot.multiply(new BigDecimal(Porcentagem.from(spred.doubleValue()).getComplemento())).setScale(2, HALF_DOWN);

		BigDecimal total = valor.multiply(cotacaoDepoisSpred);

		BigDecimal totalDepoisImpostoTaxas = total.multiply(new BigDecimal(iof.getComplemento())).subtract(taxas).setScale(2, HALF_DOWN);

		return totalDepoisImpostoTaxas.doubleValue();
	}

}
