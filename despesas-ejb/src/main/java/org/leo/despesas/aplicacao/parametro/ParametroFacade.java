package org.leo.despesas.aplicacao.parametro;

import java.math.BigDecimal;

import javax.ejb.Local;

import org.leo.despesas.dominio.servicotransferencia.Moeda;
import org.leo.despesas.dominio.servicotransferencia.Porcentagem;

@Local
public interface ParametroFacade {

	Porcentagem getValorIOF();

	BigDecimal getTaxaSpot();

	String getUrlParaCotacao(Moeda origem, Moeda destino);
}
