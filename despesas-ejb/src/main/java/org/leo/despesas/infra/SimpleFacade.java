package org.leo.despesas.infra;

import java.util.List;

import org.leo.despesas.infra.exception.DespesasException;

public interface SimpleFacade<T extends ModelEntity, F extends ModelFiltro<T>> {

	List<T> listar(F filtro);

	T buscarPorId(Long id) throws DespesasException;

	T inserir(T t) throws DespesasException;

	T salvar(T t);

	List<T> salvar(List<T> list) throws DespesasException;

	void deletar(Long id) throws DespesasException;

	List<T> fullTextSearch(String busca, String... campos);

}
