package org.leo.despesas.aplicacao.extractor;

import javax.ejb.Local;

import org.leo.despesas.dominio.extractor.ExtractVO;
import org.leo.despesas.infra.exception.DespesasException;

@Local
public interface ExtractorFacade {

	ExtractVO extrair(byte[] file, String contentType) throws DespesasException;

}
