package org.leo.despesas.infra;

import java.util.List;

public interface ContentUploadble<T extends ModelEntity> {

	List<T> carregarDeArquivo(List<String> content);

}