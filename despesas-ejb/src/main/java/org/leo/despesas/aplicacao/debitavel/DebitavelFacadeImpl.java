package org.leo.despesas.aplicacao.debitavel;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.commons.lang3.time.DateUtils;
import org.leo.despesas.aplicacao.despesa.DespesaFacade;
import org.leo.despesas.aplicacao.receita.ReceitaFacade;
import org.leo.despesas.aplicacao.transferencia.TransferenciaFacade;
import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.movimentacao.DespesaFiltro;
import org.leo.despesas.dominio.movimentacao.Movimentacao;
import org.leo.despesas.dominio.movimentacao.ReceitaFiltro;
import org.leo.despesas.dominio.movimentacao.TransferenciaFiltro;

@Stateless
public class DebitavelFacadeImpl implements DebitavelFacade {

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	@EJB
	private DespesaFacade despesaFacade;

	@EJB
	private ReceitaFacade receitaFacade;

	@EJB
	private TransferenciaFacade transferenciaFacade;

	@Override
	@SuppressWarnings("unchecked")
	public List<Debitavel> listar() {
		return entityManager.createQuery("SELECT d FROM Debitavel d").getResultList();
	}

	@Override
	public void salvar(Debitavel debitavel) {
		entityManager.merge(debitavel);
	}

	@Override
	public Debitavel buscarPorId(Object id) {
		return entityManager.find(Debitavel.class, id);
	}

	@Override
	public BigDecimal getMediaVariacao(Debitavel debitavel) {

		DespesaFiltro despesasFiltro = new DespesaFiltro();
		despesasFiltro.setDebitavel(debitavel);

		ReceitaFiltro receitasFiltro = new ReceitaFiltro();
		receitasFiltro.setDebitavel(debitavel);
		
		TransferenciaFiltro transferenciaFiltroEntrada = new TransferenciaFiltro();
		transferenciaFiltroEntrada.setCreditavel(debitavel);

		TransferenciaFiltro transferenciaFiltroSaida = new TransferenciaFiltro();
		transferenciaFiltroSaida.setCreditavel(debitavel);

		BigDecimal valorMedioDespesas = calcularMedia(despesaFacade.listar(despesasFiltro));

		BigDecimal valorMedioReceitas = calcularMedia(receitaFacade.listar(receitasFiltro));
		
		BigDecimal valorMedioTransferenciaEntrada = calcularMedia(transferenciaFacade.listar(transferenciaFiltroEntrada));
		
		BigDecimal valorMedioTransferenciaSaida = calcularMedia(transferenciaFacade.listar(transferenciaFiltroSaida));

		return valorMedioReceitas.add(valorMedioTransferenciaEntrada).subtract(valorMedioDespesas).subtract(valorMedioTransferenciaSaida).setScale(2);
	}

	private BigDecimal calcularMedia(List<? extends Movimentacao> movimentacoes) {

		BigDecimal valorTotal = BigDecimal.ZERO;

		if (movimentacoes.isEmpty()) {
			return valorTotal;
		}

		Date menorData = null;
		Date maiorData = null;

		for (Movimentacao movimentacao : movimentacoes) {

			if (menorData == null || menorData.after(movimentacao.getVencimento())) {
				menorData = movimentacao.getVencimento();
			}

			if (maiorData == null || maiorData.before(movimentacao.getVencimento())) {
				maiorData = movimentacao.getVencimento();
			}

			valorTotal = valorTotal.add(movimentacao.getValor());

		}

		return valorTotal.divide(getNumeroDeMeses(menorData, maiorData), RoundingMode.HALF_DOWN);

	}

	private BigDecimal getNumeroDeMeses(Date menorData, Date maiorData) {

		BigDecimal total = BigDecimal.ZERO;

		while (menorData.before(maiorData)) {
			total = total.add(new BigDecimal(1));
			menorData = DateUtils.addMonths(menorData, 1);
		}

		return total;
	}

}
