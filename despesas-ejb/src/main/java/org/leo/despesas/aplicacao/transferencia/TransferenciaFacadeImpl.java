package org.leo.despesas.aplicacao.transferencia;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.TypedQuery;

import org.leo.despesas.aplicacao.conta.ContaFacade;
import org.leo.despesas.aplicacao.debitavel.DebitavelFacade;
import org.leo.despesas.aplicacao.fatura.FaturaFacade;
import org.leo.despesas.aplicacao.parametro.ParametroFacade;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.dominio.movimentacao.TransferenciaFiltro;
import org.leo.despesas.dominio.servicotransferencia.Cotacao;
import org.leo.despesas.dominio.servicotransferencia.Porcentagem;
import org.leo.despesas.dominio.servicotransferencia.ServicoTransferencia;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.exception.DespesasException;

@Stateless
public class TransferenciaFacadeImpl extends AbstractFacade<Transferencia, TransferenciaFiltro> implements TransferenciaFacade {

	@EJB
	private ContaFacade contaFacade;

	@EJB
	private FaturaFacade faturaFacade;

	@EJB
	private DebitavelFacade debitavelFacade;

	@EJB
	private ParametroFacade parametroFacade;

	@Override
	public void pagarFatura(final Fatura fatura, final Conta conta, Date dataPagamento) throws DespesasException {
		final Transferencia transferencia = fatura.pagar(conta);

		transferencia.setPagamento(dataPagamento);

		inserir(transferencia);

		faturaFacade.salvar(fatura);
		contaFacade.salvar(conta);
	}

	@Override
	public List<Transferencia> getTransferenciasPorPeriodo(final Periodo periodo) {

		final StringBuilder builder = new StringBuilder();

		builder.append("SELECT t FROM Transferencia t WHERE t.vencimento BETWEEN :dataInicial AND :dataFinal ");

		final TypedQuery<Transferencia> query = entityManager.createQuery(builder.toString(), Transferencia.class);

		query.setParameter("dataInicial", periodo.getDataInicial());
		query.setParameter("dataFinal", periodo.getDataFinal());

		return query.getResultList();
	}

	@Override
	public void inserir(Transferencia t) throws DespesasException {

		if (t.getValorReal() == null) {
			t.setValorReal(t.getValor());
		}

		super.inserir(t);

		debitavelFacade.buscarPorId(t.getDebitavel().getId()).transferir(t);
		debitavelFacade.buscarPorId(t.getCreditavel().getId()).transferir(t);

	}

	@Override
	public void inserir(Transferencia transferencia, ServicoTransferencia servicoTransferencia, Cotacao cotacao) throws DespesasException {

		if (servicoTransferencia == null || cotacao == null) {
			inserir(transferencia);
		} else {

			BigDecimal spot = parametroFacade.getTaxaSpot();
			Porcentagem iof = parametroFacade.getValorIOF();

			double valorReal = servicoTransferencia.calcularValorParaTransferencia(cotacao, spot, iof, transferencia.getValor());

			transferencia.setValorReal(new BigDecimal(valorReal));
			transferencia.setDescricao("Remessa Internacional");
			transferencia.setVencimento(new Date());
			transferencia.setPagamento(new Date());
			transferencia.setMoeda(transferencia.getCreditavel().getMoeda());
			
			inserir(transferencia);
		}

	}

	@Override
	protected Class<Transferencia> getClasseEntidade() {
		return Transferencia.class;
	}

}
