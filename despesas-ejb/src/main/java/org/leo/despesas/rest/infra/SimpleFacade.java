package org.leo.despesas.rest.infra;

import java.util.List;

public interface SimpleFacade<T> {

	List<T> listar();

	T buscarPorId(Object id);

	void inserir(T t);

	void salvar(T t);

	void deletar(Long id);

}
