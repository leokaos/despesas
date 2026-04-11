package org.leo.despesas.infra;

import org.leo.despesas.dominio.extractor.ExtractVO;

public interface ContentExtractable<T extends ModelEntity> {

	T createFromExtraction(ExtractVO vo);

}
