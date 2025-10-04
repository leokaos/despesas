package org.leo.despesas.aplicacao.parametro;

import java.math.BigDecimal;
import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.servicotransferencia.Porcentagem;

@Local
public interface ParametroFacade {

	Porcentagem getValorIOF();

	BigDecimal getTaxaSpot();

	String getUrlParaCotacao();

	String buscarParametroPorId(String nome);

	Integer getDebitavelPrincipal();
	
	List<String> getIgnoreWords();
}
