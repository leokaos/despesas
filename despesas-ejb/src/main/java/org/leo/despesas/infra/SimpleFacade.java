package org.leo.despesas.infra;

import java.util.List;

import org.leo.despesas.infra.exception.DespesasException;

public interface SimpleFacade<T extends ModelEntity, F extends ModelFiltro<T>> {

	List<T> listar(F filtro);

	T buscarPorId(Long id) throws DespesasException;

	void inserir(T t) throws DespesasException;

	void salvar(T t);

	void salvar(List<T> list) throws DespesasException;

	void deletar(Long id) throws DespesasException;

}
