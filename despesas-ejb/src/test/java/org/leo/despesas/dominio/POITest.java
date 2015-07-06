package org.leo.despesas.dominio;

import java.io.FileInputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.junit.Test;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.Receita;

public class POITest {

	@Test
	public void readExcel() throws Exception {

		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");

		Workbook wb = WorkbookFactory.create(new FileInputStream("D:/Users/T802677/Downloads/maio.xls"));

		Sheet s = wb.getSheetAt(0);

		for (Row row : s) {

			Date data = format.parse(row.getCell(0).getStringCellValue());
			String descricao = row.getCell(1).getStringCellValue();
			BigDecimal valor = new BigDecimal(row.getCell(2).getNumericCellValue());

			if (valor.compareTo(BigDecimal.ZERO) < 0) {
				construirDespesa(data,descricao,valor);
			} else {
				construirReceita(data,descricao,valor);
			}
		}

		wb.close();
	}

	private Receita construirReceita(Date data,String descricao,BigDecimal valor) {
		Receita receita = new Receita();

		receita.setDescricao(descricao);
		receita.setPagamento(data);
		receita.setVencimento(data);
		receita.setValor(valor.abs());

		return receita;
	}

	private Despesa construirDespesa(Date data,String descricao,BigDecimal valor) {
		Despesa despesa = new Despesa();

		despesa.setDescricao(descricao);
		despesa.setPagamento(data);
		despesa.setVencimento(data);
		despesa.setValor(valor.abs());

		return despesa;
	}
}
