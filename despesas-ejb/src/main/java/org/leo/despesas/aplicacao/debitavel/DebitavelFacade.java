package org.leo.despesas.aplicacao.debitavel;

import java.math.BigDecimal;
import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.debitavel.DebitavelFiltro;

@Local
public interface DebitavelFacade {

	List<Debitavel> listar(DebitavelFiltro filtro);

	void salvar(Debitavel debitavel);

	Debitavel buscarPorId(Object id);

	BigDecimal getMediaVariacao(Debitavel debitavel);

}
