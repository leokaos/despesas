package org.leo.despesas.aplicacao.grafico;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.leo.despesas.aplicacao.tipodespesa.TipoDespesaFacade;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;
import org.leo.despesas.infra.grafico.GraficoLinha;
import org.leo.despesas.infra.grafico.Ponto;
import org.leo.despesas.infra.grafico.Serie;

@Stateless
public class GraficoFacadeImpl implements GraficoFacade {

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	@EJB
	private TipoDespesaFacade tipoDespesaFacade;

	@Override
	@SuppressWarnings("unchecked")
	public GraficoLinha getGraficoDespesas(final Date dataInicial, final Date dataFinal) {

		try {

			// PEGANDO OS RESULTADOS
			final StringBuilder builder = new StringBuilder();
			builder.append("SELECT d.tipo.descricao , MONTH(d.pagamento) , YEAR(d.pagamento) , SUM(d.valor) FROM Despesa d ");
			builder.append("WHERE d.pagamento BETWEEN :dataInicial AND :dataFinal ");
			builder.append("GROUP BY d.tipo.descricao , MONTH(d.pagamento) , YEAR(d.pagamento) ");
			builder.append("ORDER BY d.tipo.descricao , YEAR(d.pagamento) , MONTH(d.pagamento) ");

			final Query query = entityManager.createQuery(builder.toString());

			query.setParameter("dataInicial", dataInicial);
			query.setParameter("dataFinal", dataFinal);
			final List<Object[]> resultList = query.getResultList();

			// FORMATO OBJS: Carro 5 2015 300
			final List<Serie> series = new ArrayList<>();
			final List<TipoDespesa> listaTipoDespesas = tipoDespesaFacade.listar();
			final SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");

			Serie serie = null;
			String tipoAtual = null;

			for (final Object[] value : resultList) {

				if (serie == null || !String.valueOf(value[0]).equals(tipoAtual)) {

					tipoAtual = String.valueOf(value[0]);
					final List<Ponto> pontos = new ArrayList<Ponto>();

					serie = new Serie(tipoAtual, getCor(tipoAtual, listaTipoDespesas), pontos);

					series.add(serie);
				}

				// CÁLCULO LONG DIA
				final String data = new StringBuilder().append(1).append("-").append(value[1]).append("-").append(value[2]).toString();
				final Date dataConvertida = format.parse(data);

				final BigDecimal x = new BigDecimal(dataConvertida.getTime());
				final BigDecimal y = new BigDecimal(String.valueOf(value[3]));

				serie.getPontos().add(new Ponto(x.doubleValue(), y.doubleValue()));

			}

			return new GraficoLinha("Histórico de Despesas", series);

		} catch (final ParseException ex) {
			return null;
		}
	}

	private String getCor(final String tipoAtual, final List<TipoDespesa> listaTipoDespesas) {

		for (final TipoDespesa tipoDespesa : listaTipoDespesas) {
			if (tipoDespesa.getDescricao().equalsIgnoreCase(tipoAtual)) {
				return tipoDespesa.getCor();
			}
		}

		return null;
	}

}
