package org.leo.despesas.rest.infra;

import java.util.List;

import org.leo.despesas.infra.exception.DespesasException;

public interface SimpleFacade<T extends ModelEntity> {

	List<T> listar();

	T buscarPorId(Long id) throws DespesasException;

	void inserir(T t) throws DespesasException;

	void salvar(T t);

	void salvar(List<T> list) throws DespesasException;

	void deletar(Long id) throws DespesasException;

}
