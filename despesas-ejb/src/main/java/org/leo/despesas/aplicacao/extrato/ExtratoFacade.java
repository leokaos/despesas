package org.leo.despesas.aplicacao.extrato;

import java.util.Date;
import java.util.List;

import javax.ejb.Local;

import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.extrato.Extrato;

@Local
public interface ExtratoFacade {

	List<Extrato> buscarPorPeriodo(Date dataInicio, Date dataFinal, Debitavel debitavel);

}
