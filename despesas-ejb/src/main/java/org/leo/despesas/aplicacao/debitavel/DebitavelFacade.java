package org.leo.despesas.aplicacao.debitavel;

import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.Debitavel;

@Local
public interface DebitavelFacade {

	List<Debitavel> listar();

	void salvar(Debitavel debitavel);

	Debitavel buscarPorId(Object id);

}
