package org.leo.despesas.aplicacao.transferencia;

import javax.ejb.EJB;
import javax.ejb.Stateless;

import org.leo.despesas.aplicacao.conta.ContaFacade;
import org.leo.despesas.aplicacao.fatura.FaturaFacade;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.rest.infra.AbstractFacade;

@Stateless
public class TransferenciaFacadeImpl extends AbstractFacade<Transferencia> implements TransferenciaFacade {

	@EJB
	private ContaFacade contaFacade;

	@EJB
	private FaturaFacade faturaFacade;

	@Override
	public void pagarFatura(final Fatura fatura, final Conta conta) {
		final Transferencia transferencia = fatura.pagar(conta);

		inserir(transferencia);

		faturaFacade.salvar(fatura);
		contaFacade.salvar(conta);
	}

	@Override
	protected Class<Transferencia> getClasseEntidade() {
		return Transferencia.class;
	}

}
