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
import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.debitavel.Fatura;
import org.leo.despesas.dominio.movimentacao.Transferencia;
import org.leo.despesas.dominio.movimentacao.TransferenciaFiltro;
import org.leo.despesas.dominio.servicotransferencia.Cotacao;
import org.leo.despesas.dominio.servicotransferencia.Porcentagem;
import org.leo.despesas.dominio.servicotransferencia.ServicoTransferencia;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.infra.exception.ValidationEntityException;

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
	public void pagarFatura(Fatura fatura, final Conta conta, Date dataPagamento) throws DespesasException {

		fatura = faturaFacade.buscarPorId(fatura.getId());

		final Transferencia transferencia = fatura.pagar(conta);

		transferencia.setPagamento(dataPagamento);

		inserir(transferencia);
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
	protected void preInserir(Transferencia t) throws DespesasException {

		if (t.getDebitavel().getMoeda() != t.getCreditavel().getMoeda()) {
			throw new ValidationEntityException("Transferência entre debitáveis com diferentes moedas não permitado!");
		}

	}

	@Override
	public Transferencia inserir(Transferencia t) throws DespesasException {

		preInserir(t);

		if (t.getValorReal() == null) {
			t.setValorReal(t.getValor());
		}

		Transferencia transferencia = super.inserir(t);

		debitavelFacade.buscarPorId(t.getDebitavel().getId()).transferir(t);
		debitavelFacade.buscarPorId(t.getCreditavel().getId()).transferir(t);

		return transferencia;
	}

	@Override
	public Transferencia inserir(Transferencia transferencia, ServicoTransferencia servicoTransferencia, Cotacao cotacao) throws DespesasException {

		if (servicoTransferencia == null || cotacao == null) {
			return inserir(transferencia);
		} else {

			BigDecimal spot = parametroFacade.getTaxaSpot();
			Porcentagem iof = parametroFacade.getValorIOF();

			double valorReal = servicoTransferencia.calcularValorParaTransferencia(cotacao, spot, iof, transferencia.getValor());

			transferencia.setValorReal(new BigDecimal(valorReal));
			transferencia.setDescricao("Remessa Internacional");
			transferencia.setVencimento(new Date());
			transferencia.setPagamento(new Date());
			transferencia.setMoeda(transferencia.getCreditavel().getMoeda());

			return inserir(transferencia);
		}

	}

	@Override
	protected void preSalvar(Transferencia antigo, Transferencia novo) throws DespesasException {

		if (novo.getValorReal() == null) {
			if (novo.getCreditavel().getMoeda() == novo.getDebitavel().getMoeda()) {
				novo.setValorReal(novo.getValor());
			} else {
				throw new ValidationEntityException("Alteração em transferências entre debitáveis com diferentes moedas não permitado!");
			}
		}
	}

	@Override
	protected void posSalvar(Transferencia antigo, Transferencia novo) throws DespesasException {

		debitavelFacade.buscarPorId(antigo.getDebitavel().getId()).estornar(antigo);
		debitavelFacade.buscarPorId(antigo.getCreditavel().getId()).estornar(antigo);

		debitavelFacade.buscarPorId(novo.getDebitavel().getId()).transferir(novo);
		debitavelFacade.buscarPorId(novo.getCreditavel().getId()).transferir(novo);
	}

	@Override
	protected Class<Transferencia> getClasseEntidade() {
		return Transferencia.class;
	}

	@Override
	protected void posDeletar(Transferencia transferencia) {

		Debitavel debitavel = debitavelFacade.buscarPorId(transferencia.getDebitavel().getId());
		Debitavel creditavel = debitavelFacade.buscarPorId(transferencia.getCreditavel().getId());

		debitavel.estornar(transferencia);
		creditavel.estornar(transferencia);
	}

}
