package org.leo.despesas.aplicacao.despesa;

import java.util.List;

import org.leo.despesas.infra.ModelEntity;

public interface ContentUploadble<T extends ModelEntity> {

	List<T> carregarDeArquivo(List<String> content);

}