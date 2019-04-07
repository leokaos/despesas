package org.leo.despesas.aplicacao.cartao;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.CartaoCreditoFiltro;
import org.leo.despesas.rest.infra.SimpleFacade;

@Local
public interface CartaoFacade extends SimpleFacade<CartaoCredito, CartaoCreditoFiltro> {

}
