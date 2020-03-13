package org.leo.despesas.aplicacao.transferencia;

import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.Query;

import org.leo.despesas.aplicacao.conta.ContaFacade;
import org.leo.despesas.aplicacao.fatura.FaturaFacade;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.dominio.movimentacao.TransferenciaFiltro;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.rest.infra.AbstractFacade;

@Stateless
public class TransferenciaFacadeImpl extends AbstractFacade<Transferencia, TransferenciaFiltro> implements TransferenciaFacade {

	@EJB
	private ContaFacade contaFacade;

	@EJB
	private FaturaFacade faturaFacade;

	@Override
	public void pagarFatura(final Fatura fatura, final Conta conta, Date dataPagamento) throws DespesasException {
		final Transferencia transferencia = fatura.pagar(conta);

		transferencia.setPagamento(dataPagamento);

		inserir(transferencia);

		faturaFacade.salvar(fatura);
		contaFacade.salvar(conta);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Transferencia> getTransferenciasPorPeriodo(final Periodo periodo) {

		final StringBuilder builder = new StringBuilder();

		builder.append("SELECT t FROM Transferencia t WHERE t.vencimento BETWEEN :dataInicial AND :dataFinal ");

		final Query query = entityManager.createQuery(builder.toString());

		query.setParameter("dataInicial", periodo.getDataInicial());
		query.setParameter("dataFinal", periodo.getDataFinal());

		return query.getResultList();
	}

	@Override
	public void inserir(Transferencia t) throws DespesasException {

		super.inserir(t);

		contaFacade.buscarPorId(t.getDebitavel().getId()).transferir(t);
		contaFacade.buscarPorId(t.getCreditavel().getId()).transferir(t);

	}

	@Override
	protected Class<Transferencia> getClasseEntidade() {
		return Transferencia.class;
	}

}
