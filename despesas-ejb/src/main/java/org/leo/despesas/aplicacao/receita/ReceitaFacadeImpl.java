package org.leo.despesas.aplicacao.receita;

import java.io.File;
import java.io.FileInputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.Query;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.leo.despesas.aplicacao.debitavel.DebitavelFacade;
import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.ReceitaFiltro;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.Moeda;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.rest.GraficoVO;

@Stateless
public class ReceitaFacadeImpl extends AbstractFacade<Receita, ReceitaFiltro> implements ReceitaFacade {

	@EJB
	private DebitavelFacade debitavelFacade;

	@Override
	@SuppressWarnings("unchecked")
	public List<GraficoVO> getGraficoPorPeriodo(final Periodo periodo) {
		final StringBuilder builder = new StringBuilder();

		builder.append("SELECT NEW org.leo.despesas.rest.GraficoVO(r.tipo.descricao,r.tipo.cor, SUM(r.valor)) FROM Receita r ");
		builder.append("WHERE r.vencimento BETWEEN :dataInicial AND :dataFinal AND r.moeda = :moeda ");
		builder.append("GROUP BY r.tipo.descricao, r.tipo.cor");

		final Query query = entityManager.createQuery(builder.toString());

		query.setParameter("dataInicial", periodo.getDataInicial());
		query.setParameter("dataFinal", periodo.getDataFinal());
		query.setParameter("moeda", Moeda.EURO);

		return query.getResultList();
	}

	@Override
	protected Class<Receita> getClasseEntidade() {
		return Receita.class;
	}

	@Override
	protected void posInserir(Receita receita) {

		if (receita.isDepositado()) {
			depositar(receita);
		}
	}

	@Override
	protected void posSalvar(Receita antigo, Receita novo) {

		if (!antigo.isDepositado() && novo.isDepositado()) {
			depositar(novo);
		}
	}

	@Override
	public void depositar(final Receita receita) {
		receita.setDebitavel(debitavelFacade.buscarPorId(receita.getDebitavel().getId()));

		receita.depositar();

		debitavelFacade.salvar(receita.getDebitavel());
	}

	@Override
	public List<Receita> carregarDeArquivo(final File arquivoReceitas) {

		try {

			final List<Receita> lista = new ArrayList<>();

			final SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");

			final Workbook wb = new HSSFWorkbook(new FileInputStream(arquivoReceitas));

			final Sheet s = wb.getSheetAt(0);

			for (final Row row : s) {

				final Date data = format.parse(row.getCell(0).getStringCellValue());
				final String descricao = row.getCell(1).getStringCellValue();
				final BigDecimal valor = new BigDecimal(row.getCell(2).getNumericCellValue());

				lista.add(construirReceita(data, descricao, valor));
			}

			wb.close();

			return lista;

		} catch (final Exception ex) {
			ex.printStackTrace();
		}

		return null;
	}

	private Receita construirReceita(final Date data, final String descricao, final BigDecimal valor) {

		final Receita receita = new Receita();

		receita.setDescricao(descricao);
		receita.setPagamento(data);
		receita.setVencimento(data);
		receita.setValor(valor.abs());

		return receita;
	}

	@Override
	protected void posDeletar(Receita receita) {

		if (receita.isDepositado()) {

			Debitavel debitavel = debitavelFacade.buscarPorId(receita.getDebitavel().getId());

			debitavel.estornar(receita);
		}
	}

}
