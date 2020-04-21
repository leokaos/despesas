package org.leo.despesas.aplicacao.parametro;

import java.math.BigDecimal;

import javax.ejb.Local;

import org.leo.despesas.dominio.servicotransferencia.Porcentagem;
import org.leo.despesas.infra.Moeda;

@Local
public interface ParametroFacade {

	Porcentagem getValorIOF();

	BigDecimal getTaxaSpot();

	String getUrlParaCotacao(Moeda origem, Moeda destino);

	String buscarParametroPorId(String nome);

	Integer getDebitavelPrincipal();
}
