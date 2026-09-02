package org.leo.despesas.dominio.debitavel;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.rest.DebitavelSerializerVisitorImpl;

@Entity
@Table(name = "ativo", schema = "despesas_db")
public class Ativo extends Debitavel {

	private static final long serialVersionUID = 4734557151152113449L;

	public static final String CODIGO_TIPO = "ATIVO";

	@Column(name = "valor_total")
	private BigDecimal valorTotal;

	public Ativo() {
		super();

		setTipo(CODIGO_TIPO);
	}

	public String getTipo() {
		return CODIGO_TIPO;
	}

	@Override
	public void debitar(Despesa despesa) {

	}

	@Override
	public void creditar(Receita receita) {

	}

	@Override
	public void transferir(Transferencia transferencia) {

		if (transferencia.getCreditavel().getId() == getId()) {
			valorTotal = valorTotal.add(transferencia.getValor());
		}

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
		return this.valorTotal;
	}

	@Override
	public void estornar(Despesa despesa) {
	}

	@Override
	public void estornar(Receita receita) {

	}

	@Override
	public void estornar(Transferencia transferencia) {

		if (transferencia.getCreditavel().getId() == getId()) {
			valorTotal = valorTotal.subtract(transferencia.getValor());
		}

	}

}
