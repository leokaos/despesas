package org.leo.despesas.aplicacao.parametro;

import java.math.BigDecimal;
import java.text.MessageFormat;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.leo.despesas.dominio.parametro.Parametro;
import org.leo.despesas.dominio.servicotransferencia.Porcentagem;
import org.leo.despesas.infra.Moeda;

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
	public String getUrlParaCotacao(Moeda origem, Moeda destino) {

		String key = MessageFormat.format("{0}.{1}", origem, destino);

		Parametro parametro = entityManager.find(Parametro.class, key);

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
