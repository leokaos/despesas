package org.leo.despesas.infra;

import java.util.List;

import javax.ws.rs.core.Response;

import org.leo.despesas.infra.exception.DespesasException;

public interface SimpleService<T extends ModelEntity, F extends ModelFiltro<T>> {

	List<T> listar(F filtro);

	Response buscarPorId(Long id) throws DespesasException;

	Response inserir(T t) throws DespesasException;

	Response salvar(T t) throws DespesasException;

	Response deletar(Long id) throws DespesasException;

}
