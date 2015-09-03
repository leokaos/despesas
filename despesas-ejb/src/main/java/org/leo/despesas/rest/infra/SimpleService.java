package org.leo.despesas.rest.infra;

import java.util.List;

import javax.ws.rs.core.Response;

import org.leo.despesas.infra.exception.DespesasException;

public interface SimpleService<T extends ModelEntity> {

	List<T> listar();

	Response buscarPorId(Long id) throws DespesasException;

	Response inserir(T t) throws DespesasException;

	Response salvar(T t);

	Response deletar(Long id) throws DespesasException;
}
