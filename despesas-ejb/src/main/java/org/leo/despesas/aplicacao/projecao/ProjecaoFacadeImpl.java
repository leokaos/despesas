package org.leo.despesas.aplicacao.projecao;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;

import javax.ejb.EJB;
import javax.ejb.Stateless;

import org.leo.despesas.aplicacao.debitavel.DebitavelFacade;
import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.projecao.Projecao;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.exception.DespesasException;

@Stateless
public class ProjecaoFacadeImpl implements ProjecaoFacade {

	@EJB
	private DebitavelFacade debitavelFacade;

	@Override
	public Projecao criarProjecao(Debitavel debitavel, Periodo periodo) throws DespesasException {

		if (periodo.getDataInicial().before(new Date())) {
			throw new DespesasException("Data inválida!");
		}

		Projecao projecao = new Projecao();

		BigDecimal valorMedio = debitavelFacade.getMediaVariacao(debitavel);
		BigDecimal saldo = debitavel.getSaldo();

		Iterator<Date> it = periodo.getIterator(Calendar.MONTH);

		while (it.hasNext()) {
			saldo = saldo.add(valorMedio);
			projecao.addItem(it.next(), saldo);
		}

		return projecao;
	}

}
