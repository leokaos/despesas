package org.leo.despesas.aplicacao.despesa;

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
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.DespesaFiltro;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.rest.GraficoVO;
import org.leo.despesas.rest.ParcelamentoVO;

@Stateless
public class DespesaFacadeImpl extends AbstractFacade<Despesa, DespesaFiltro> implements DespesaFacade {

	@EJB
	private DebitavelFacade debitavelFacade;

	@Override
	@SuppressWarnings("unchecked")
	public List<GraficoVO> getGraficoPorPeriodo(final Periodo periodo) {
		final StringBuilder builder = new StringBuilder();

		builder.append("SELECT NEW org.leo.despesas.rest.GraficoVO(d.tipo.descricao,d.tipo.cor, SUM(d.valor)) FROM Despesa d ");
		builder.append("WHERE d.vencimento BETWEEN :dataInicial AND :dataFinal ");
		builder.append("GROUP BY d.tipo.descricao, d.tipo.cor");

		final Query query = entityManager.createQuery(builder.toString());

		query.setParameter("dataInicial", periodo.getDataInicial());
		query.setParameter("dataFinal", periodo.getDataFinal());

		return query.getResultList();
	}

	@Override
	protected Class<Despesa> getClasseEntidade() {
		return Despesa.class;
	}

	@Override
	public Despesa inserir(final Despesa despesa) throws DespesasException {
		return inserir(despesa, null);
	}

	@Override
	public Despesa inserir(final Despesa despesa, final ParcelamentoVO parcelamentoVO) throws DespesasException {

		if (parcelamentoVO != null) {

			salvar(parcelamentoVO.getTipoParcelamento().parcelar(despesa, parcelamentoVO.getNumeroParcelas()));

			return null;

		} else {

			if (despesa.isPaga()) {
				pagar(despesa);
			}

			return super.inserir(despesa);
		}
	}

	@Override
	public void pagar(final Despesa despesa) {

		despesa.setDebitavel(debitavelFacade.buscarPorId(despesa.getDebitavel().getId()));

		despesa.pagar();

		debitavelFacade.salvar(despesa.getDebitavel());

		despesa.consolidar();
	}

	@Override
	public List<Despesa> carregarDeArquivo(final File arquivoDespesas) {

		try {

			final List<Despesa> lista = new ArrayList<>();

			final SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");

			final Workbook wb = new HSSFWorkbook(new FileInputStream(arquivoDespesas));

			final Sheet s = wb.getSheetAt(0);

			for (final Row row : s) {

				final Date data = format.parse(row.getCell(0).getStringCellValue());
				final String descricao = row.getCell(1).getStringCellValue().trim();
				final BigDecimal valor = new BigDecimal(row.getCell(2).getNumericCellValue());

				lista.add(construirDespesa(data, descricao, valor));
			}

			wb.close();

			return lista;

		} catch (final Exception ex) {
			ex.printStackTrace();
		}

		return null;
	}

	private Despesa construirDespesa(final Date data, final String descricao, final BigDecimal valor) {
		final Despesa despesa = new Despesa();

		despesa.setDescricao(descricao);
		despesa.setPagamento(data);
		despesa.setVencimento(data);
		despesa.setValor(valor.abs());

		return despesa;
	}

	@Override
	protected void posDeletar(Despesa despesa) {

		Debitavel debitavel = debitavelFacade.buscarPorId(despesa.getDebitavel().getId());

		debitavel.estornar(despesa);
	}
}
