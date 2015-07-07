package org.leo.despesas.aplicacao.grafico;

import java.math.BigDecimal;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.leo.despesas.aplicacao.tipodespesa.TipoDespesaFacade;
import org.leo.despesas.dominio.movimentacao.GraficoLinhaVO;
import org.leo.despesas.dominio.movimentacao.GraficoVO;
import org.leo.despesas.dominio.movimentacao.WrapperGraficoVO;
import org.leo.despesas.dominio.tipomovimentacao.TipoDespesa;

@Stateless
public class GraficoFacadeImpl implements GraficoFacade {

	private static final String FORMATO = "{0}/{1} {2}";

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	@EJB
	private TipoDespesaFacade tipoDespesaFacade;

	@Override
	@SuppressWarnings("unchecked")
	public WrapperGraficoVO getGraficoDespesas(final Date dataInicial, final Date dataFinal) {
		final StringBuilder builder = new StringBuilder();

		builder.append("SELECT d.tipo.descricao , MONTH(d.pagamento) , YEAR(d.pagamento) , SUM(d.valor) FROM Despesa d ");
		builder.append("WHERE d.pagamento BETWEEN :dataInicial AND :dataFinal ");
		builder.append("GROUP BY d.tipo.descricao , MONTH(d.pagamento) , YEAR(d.pagamento) ");

		final Query query = entityManager.createQuery(builder.toString());

		query.setParameter("dataInicial", dataInicial);
		query.setParameter("dataFinal", dataFinal);

		final List<Object[]> resultList = query.getResultList();
		final List<GraficoLinhaVO> listaGraficos = new ArrayList<GraficoLinhaVO>();
		final List<TipoDespesa> tiposDespesas = tipoDespesaFacade.listar();

		for (final Object[] value : resultList) {

			final String legenda = MessageFormat.format(FORMATO, value[0], value[1].toString(), value[2]);

			listaGraficos.add(new GraficoVO(legenda, getColorTipo(values[2], tiposDespesas), (BigDecimal) values[3]));

		}

		return null;
	}

	@Override
	public WrapperGraficoVO getGraficoReceitas(final Date dataInicial, final Date dataFinal) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public WrapperGraficoVO getExtrato(final Date dataInicial, final Date dataFinal) {
		// TODO Auto-generated method stub
		return null;
	}

}
