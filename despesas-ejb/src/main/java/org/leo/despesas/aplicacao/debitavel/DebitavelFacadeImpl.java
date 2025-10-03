package org.leo.despesas.aplicacao.debitavel;

import static org.apache.commons.lang3.time.DateUtils.isSameDay;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.apache.commons.lang3.time.DateUtils;
import org.leo.despesas.aplicacao.despesa.DespesaFacade;
import org.leo.despesas.aplicacao.parametro.ParametroFacade;
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

	@EJB
	private ParametroFacade parametroFacade;

	@Override
	public List<Debitavel> listar(Boolean ativo) {

		String strQuery = "SELECT d FROM Debitavel d";

		if (ativo != null) {
			strQuery += " WHERE d.ativo = :ativo";
		}

		TypedQuery<Debitavel> query = entityManager.createQuery(strQuery, Debitavel.class);

		if (ativo != null) {
			query.setParameter("ativo", ativo);
		}

		List<Debitavel> resultList = query.getResultList();

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

		while (menorData.before(maiorData) || isSameDay(menorData, maiorData)) {
			total = total.add(new BigDecimal(1));
			menorData = DateUtils.addMonths(menorData, 1);
		}

		return total;
	}

}
