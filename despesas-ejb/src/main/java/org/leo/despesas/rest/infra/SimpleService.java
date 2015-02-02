package org.leo.despesas.rest.infra;

import java.util.List;

import javax.ws.rs.core.Response;

public interface SimpleService<T> {

	List<T> listar();

	T buscarPorId(Long id);

	Response inserir(T t);

	Response salvar(T t);

	Response deletar(Long id);
}
