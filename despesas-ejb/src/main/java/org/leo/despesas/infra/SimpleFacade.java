package org.leo.despesas.infra;

import java.util.List;

public interface SimpleFacade<T> {

	List<T> listar();

	T buscarPorId(Long id);

	void inserir(T t);

	void salvar(T t);

	void salvar(List<T> list);

	void deletar(Long id);

}
