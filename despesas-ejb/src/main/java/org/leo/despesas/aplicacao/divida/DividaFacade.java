package org.leo.despesas.aplicacao.divida;

import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.Divida;
import org.leo.despesas.dominio.debitavel.DividaFiltro;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.infra.SimpleFacade;
import org.leo.despesas.infra.exception.DespesasException;

@Local
public interface DividaFacade extends SimpleFacade<Divida, DividaFiltro> {

	List<Transferencia> getPagamentos(Long id) throws DespesasException;

}
