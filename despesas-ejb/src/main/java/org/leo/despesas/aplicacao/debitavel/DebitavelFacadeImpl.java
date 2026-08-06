package org.leo.despesas.aplicacao.debitavel;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Collections;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.leo.despesas.aplicacao.despesa.DespesaFacade;
import org.leo.despesas.aplicacao.parametro.ParametroFacade;
import org.leo.despesas.aplicacao.receita.ReceitaFacade;
import org.leo.despesas.aplicacao.transferencia.TransferenciaFacade;
import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.debitavel.DebitavelFiltro;
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

	@EJB
	private ParametroFacade parametroFacade;

	@Override
	public List<Debitavel> listar(DebitavelFiltro filtro) {

		List<Debitavel> resultList = filtro.getLista(entityManager, Debitavel.class);

		Collections.sort(resultList, new DebitavelPreferivelComparator(parametroFacade.getDebitavelPrincipal()));

		return resultList;
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
		transferenciaFiltroSaida.setDebitavel(debitavel);

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

		LocalDate menorData = null;
		LocalDate maiorData = null;

		for (Movimentacao movimentacao : movimentacoes) {

			if (menorData == null || menorData.isAfter(movimentacao.getVencimento())) {
				menorData = movimentacao.getVencimento();
			}

			if (maiorData == null || maiorData.isBefore(movimentacao.getVencimento())) {
				maiorData = movimentacao.getVencimento();
			}

			valorTotal = valorTotal.add(movimentacao.getValor());

		}

		return valorTotal.divide(getNumeroDeMeses(menorData, maiorData), RoundingMode.HALF_DOWN);

	}

	private BigDecimal getNumeroDeMeses(LocalDate menorData, LocalDate maiorData) {

		long count = ChronoUnit.MONTHS.between(menorData, maiorData) + 1;

		return BigDecimal.valueOf(count);
	}

}
