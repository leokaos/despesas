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
import org.leo.despesas.aplicacao.tiporeceita.TipoReceitaFacade;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesaFiltro;
import org.leo.despesas.dominio.tipomovimentacao.TipoMovimentacao;
import org.leo.despesas.dominio.tipomovimentacao.TipoReceitaFiltro;
import org.leo.despesas.infra.Moeda;
import org.leo.despesas.infra.grafico.GraficoLinha;
import org.leo.despesas.infra.grafico.Ponto;
import org.leo.despesas.infra.grafico.Serie;

@Stateless
public class GraficoFacadeImpl implements GraficoFacade {

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	@EJB
	private TipoDespesaFacade tipoDespesaFacade;

	@EJB
	private TipoReceitaFacade tipoReceitaFacade;

	@Override
	public GraficoLinha getGraficoDespesas(final Date dataInicial, final Date dataFinal) {

		try {

			// PEGANDO OS RESULTADOS
			final StringBuilder builder = new StringBuilder();
			builder.append("SELECT d.tipo.descricao , MONTH(d.vencimento) , YEAR(d.vencimento) , SUM(d.valor) FROM Despesa d ");
			builder.append("WHERE d.vencimento BETWEEN :dataInicial AND :dataFinal AND d.moeda = :moeda ");
			builder.append("GROUP BY d.tipo.descricao , MONTH(d.vencimento) , YEAR(d.vencimento) ");
			builder.append("ORDER BY d.tipo.descricao , YEAR(d.vencimento) , MONTH(d.vencimento) ");

			final List<? extends TipoMovimentacao> listaTipoDespesas = tipoDespesaFacade.listar(new TipoDespesaFiltro());

			return gerarGrafico(dataInicial, dataFinal, builder, listaTipoDespesas, "Histórico de Despesas");

		} catch (final ParseException ex) {
			return null;
		}
	}

	@Override
	public GraficoLinha getGraficoReceitas(Date dataInicial, Date dataFinal) {

		try {

			// PEGANDO OS RESULTADOS
			final StringBuilder builder = new StringBuilder();
			builder.append("SELECT r.tipo.descricao , MONTH(r.vencimento) , YEAR(r.vencimento) , SUM(r.valor) FROM Receita r ");
			builder.append("WHERE r.vencimento BETWEEN :dataInicial AND :dataFinal AND r.moeda = :moeda ");
			builder.append("GROUP BY r.tipo.descricao , MONTH(r.vencimento) , YEAR(r.vencimento) ");
			builder.append("ORDER BY r.tipo.descricao , YEAR(r.vencimento) , MONTH(r.vencimento) ");

			final List<? extends TipoMovimentacao> listaTipoDespesas = tipoReceitaFacade.listar(new TipoReceitaFiltro());

			return gerarGrafico(dataInicial, dataFinal, builder, listaTipoDespesas, "Histórico de Receita");

		} catch (final ParseException ex) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	private GraficoLinha gerarGrafico(final Date dataInicial, final Date dataFinal, final StringBuilder builder, final List<? extends TipoMovimentacao> listaTipoDespesas, String titulo) throws ParseException {

		final Query query = entityManager.createQuery(builder.toString());

		query.setParameter("dataInicial", dataInicial);
		query.setParameter("dataFinal", dataFinal);
		query.setParameter("moeda", Moeda.EURO);
		final List<Object[]> resultList = query.getResultList();

		// FORMATO OBJS: Carro 5 2015 300
		final List<Serie> series = new ArrayList<>();
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

		return new GraficoLinha(titulo, series);
	}

	private String getCor(final String tipoAtual, final List<? extends TipoMovimentacao> listaTipoDespesas) {

		for (final TipoMovimentacao tipoDespesa : listaTipoDespesas) {
			if (tipoDespesa.getDescricao().equalsIgnoreCase(tipoAtual)) {
				return tipoDespesa.getCor();
			}
		}

		return null;
	}

}
