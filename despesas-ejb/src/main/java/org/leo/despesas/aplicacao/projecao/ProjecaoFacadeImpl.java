package org.leo.despesas.aplicacao.projecao;

import static org.leo.despesas.infra.util.DataUtil.CLOCK;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
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

		if (periodo.getDataInicial().isBefore(LocalDate.now(CLOCK))) {
			throw new DespesasException("Data inválida!");
		}

		Projecao projecao = new Projecao();

		BigDecimal valorMedio = debitavelFacade.getMediaVariacao(debitavel);
		BigDecimal saldo = debitavel.getSaldo();

		Iterator<LocalDate> it = periodo.getIterator(ChronoUnit.MONTHS);

		while (it.hasNext()) {
			saldo = saldo.add(valorMedio);
			projecao.addItem(it.next(), saldo);
		}

		return projecao;
	}

}
