package org.leo.despesas.aplicacao.parametro;

import java.math.BigDecimal;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.leo.despesas.dominio.parametro.Parametro;
import org.leo.despesas.dominio.servicotransferencia.Porcentagem;

import com.google.common.collect.Lists;

@Stateless
public class ParametroFacadeIml implements ParametroFacade {

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	@Override
	public Porcentagem getValorIOF() {

		Parametro parametro = entityManager.find(Parametro.class, "IOF");

		return Porcentagem.from(Double.parseDouble(parametro.getValor()));
	}

	@Override
	public BigDecimal getTaxaSpot() {

		Parametro parametro = entityManager.find(Parametro.class, "SPOT");

		return new BigDecimal(parametro.getValor());
	}

	@Override
	public Integer getDebitavelPrincipal() {

		Parametro parametro = entityManager.find(Parametro.class, "DEBITAVEL_PRINCIPAL");

		return Integer.valueOf(parametro.getValor());
	}

	@Override
	public String getUrlParaCotacao() {

		Parametro parametro = entityManager.find(Parametro.class, "COTACAO_URL");

		return parametro.getValor();
	}

	@Override
	public String buscarParametroPorId(String nome) {

		Parametro parametro = entityManager.find(Parametro.class, nome);

		return parametro.getValor();
	}

	@Override
	public List<String> getIgnoreWords() {

		Parametro parametro = entityManager.find(Parametro.class, "IGNORE_WORDS");

		return Lists.newArrayList(parametro.getValor().split(" "));
	}

}
