package org.leo.despesas.rest.despesa;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.util.IOUtils;
import org.jboss.resteasy.plugins.providers.multipart.InputPart;
import org.jboss.resteasy.plugins.providers.multipart.MultipartFormDataInput;
import org.leo.despesas.aplicacao.despesa.DespesaFacade;
import org.leo.despesas.dominio.debitavel.DespesaFiltro;
import org.leo.despesas.dominio.debitavel.DespesaVO;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.GraficoVO;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.rest.infra.AbstractService;

@Path("/despesa")
@RequestScoped
public class DespesaService extends AbstractService<DespesaFacade,Despesa> {

	@EJB
	private DespesaFacade despesaFacade;

	@GET
	@Path(value = "/grafico")
	@Produces(MediaType.APPLICATION_JSON)
	public List<GraficoVO> buscarPorPeriodo(@QueryParam("dataInicial") Date dataInicial,@QueryParam("dataFinal") Date dataFinal) {
		return despesaFacade.getGraficoPorPeriodo(new Periodo(dataInicial,dataFinal));
	}

	@GET
	@Path(value = "/periodo")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Despesa> buscarPorDespesasPorPeriodo(@QueryParam("dataInicial") Date dataInicial,@QueryParam("dataFinal") Date dataFinal) {
		return despesaFacade.getDespesasPorPeriodo(new Periodo(dataInicial,dataFinal));
	}

	@POST
	@Path(value = "/filtro")
	@Consumes(MediaType.APPLICATION_JSON)
	public List<Despesa> buscarPorFiltro(DespesaFiltro filtro) {
		return getFacade().buscarPorFiltro(filtro);
	}

	@POST
	@Consumes(value = MediaType.APPLICATION_JSON)
	public Response inserir(DespesaVO despesaVO) {

		despesaFacade.inserir(despesaVO.getDespesa(),despesaVO.getParcelamentoVO());

		return Response.status(200).build();
	}

	@Override
	public Response inserir(Despesa t) {
		return Response.noContent().build();
	}

	@POST
	@Path(value = "/pagar")
	public void pagar(Long id) {
		despesaFacade.pagar(despesaFacade.buscarPorId(id));
	}

	@Override
	protected DespesaFacade getFacade() {
		return this.despesaFacade;
	}

	// TESTE MASTER

	@POST
	@Path("/upload")
	@Consumes("multipart/form-data")
	@Produces(value = MediaType.APPLICATION_JSON)
	public List<Despesa> uploadFile(MultipartFormDataInput input) {

		String fileName = "";

		Map<String,List<InputPart>> uploadForm = input.getFormDataMap();
		List<InputPart> inputParts = uploadForm.get("arquivo");

		for (InputPart inputPart : inputParts) {

			try {

				fileName = "churros.xls";

				// convert the uploaded file to inputstream
				InputStream inputStream = inputPart.getBody(InputStream.class,null);

				byte[] bytes = IOUtils.toByteArray(inputStream);

				// constructs upload file path
				fileName = "c:/temp/" + fileName;

				File file = new File(fileName);

				if (!file.exists()) {
					file.createNewFile();
				}

				FileOutputStream fop = new FileOutputStream(file);

				fop.write(bytes);
				fop.flush();
				fop.close();

				System.out.println("Done");

				return readExcel(fileName);

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return null;
	}

	public List<Despesa> readExcel(String arquivo) throws Exception {

		List<Despesa> lista = new ArrayList<>();

		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");

		// Workbook wb = new XSSFWorkbook(new FileInputStream(arquivo));

		Workbook wb = new HSSFWorkbook(new FileInputStream(arquivo));

		Sheet s = wb.getSheetAt(0);

		for (Row row : s) {

			Date data = format.parse(row.getCell(0).getStringCellValue());
			String descricao = row.getCell(1).getStringCellValue();
			BigDecimal valor = new BigDecimal(row.getCell(2).getNumericCellValue());

			if (valor.compareTo(BigDecimal.ZERO) < 0) {
				lista.add(construirDespesa(data,descricao,valor));
			} else {
				construirReceita(data,descricao,valor);
			}
		}

		wb.close();

		return lista;
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
