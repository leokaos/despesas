package org.leo.despesas.aplicacao.fatura;

import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.TypedQuery;

import org.leo.despesas.aplicacao.transferencia.TransferenciaFacade;
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.debitavel.FaturaFiltro;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.exception.DespesasException;

import com.google.common.collect.Lists;

@Stateless
public class FaturaFacadeImpl extends AbstractFacade<Fatura, FaturaFiltro> implements FaturaFacade {

	@EJB
	private TransferenciaFacade transferenciaFacade;

	@Override
	protected Class<Fatura> getClasseEntidade() {
		return Fatura.class;
	}

	@Override
	public List<Fatura> buscarFaturaPorCartaoCredito(CartaoCredito cartaoCredito) {

		List<Fatura> faturas = Lists.newArrayList();

		TypedQuery<Fatura> query = entityManager.createQuery("SELECT f FROM Fatura f WHERE f.cartao = :cartao ORDER BY f.dataFechamento DESC", Fatura.class);

		query.setParameter("cartao", cartaoCredito);

		faturas.addAll(query.getResultList());

		return faturas;
	}

	@Override
	public Fatura pagarFatura(Fatura fatura, final Conta conta, Date dataPagamento) throws DespesasException {

		fatura = buscarPorId(fatura.getId());

		final Transferencia transferencia = fatura.pagar(conta);

		transferencia.setPagamento(dataPagamento);

		transferenciaFacade.inserir(transferencia);

		return fatura;
	}

	@Override
	protected void preDeletar(Fatura fatura) throws DespesasException {

		if (fatura.hasDespesas()) {
			throw new DespesasException("Fatura contém despesas!");
		}
	}

	@Override
	protected String getTopicName() {
		return "fatura";
	}

}