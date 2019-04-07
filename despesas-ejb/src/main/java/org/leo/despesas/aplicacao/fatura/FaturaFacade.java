package org.leo.despesas.aplicacao.fatura;

import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.debitavel.FaturaFiltro;
import org.leo.despesas.rest.infra.SimpleFacade;

@Local
public interface FaturaFacade extends SimpleFacade<Fatura, FaturaFiltro> {

	List<Fatura> buscarFaturaPorCartaoCredito(CartaoCredito cartaoCredito);

}
