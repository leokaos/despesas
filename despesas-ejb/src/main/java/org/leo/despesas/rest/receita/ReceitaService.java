package org.leo.despesas.rest.receita;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
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

import org.apache.poi.util.IOUtils;
import org.jboss.resteasy.plugins.providers.multipart.InputPart;
import org.jboss.resteasy.plugins.providers.multipart.MultipartFormDataInput;
import org.leo.despesas.aplicacao.receita.ReceitaFacade;
import org.leo.despesas.dominio.movimentacao.GraficoVO;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.ReceitaFiltro;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.rest.infra.AbstractService;

@Path("/receita")
@RequestScoped
public class ReceitaService extends AbstractService<ReceitaFacade,Receita> {

	private static final String NOME_CAMPO = "arquivo";

	@EJB
	private ReceitaFacade receitaFacade;

	@GET
	@Path(value = "/grafico")
	@Produces(MediaType.APPLICATION_JSON)
	public List<GraficoVO> buscarPorPeriodo(@QueryParam("dataInicial") final Date dataInicial,@QueryParam("dataFinal") final Date dataFinal) {
		return receitaFacade.getGraficoPorPeriodo(new Periodo(dataInicial,dataFinal));
	}

	@GET
	@Path(value = "/periodo")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Receita> buscarPorDespesasPorPeriodo(@QueryParam("dataInicial") final Date dataInicial,@QueryParam("dataFinal") final Date dataFinal) {
		return receitaFacade.getReceitasPorPeriodo(new Periodo(dataInicial,dataFinal));
	}

	@POST
	@Path(value = "/filtro")
	@Consumes(MediaType.APPLICATION_JSON)
	public List<Receita> buscarPorFiltro(final ReceitaFiltro filtro) {
		return getFacade().buscarPorFiltro(filtro);
	}

	@POST
	@Path(value = "/depositar")
	public void depositar(final Long id) throws DespesasException {
		receitaFacade.depositar(receitaFacade.buscarPorId(id));
	}

	@Override
	protected ReceitaFacade getFacade() {
		return this.receitaFacade;
	}

	@POST
	@Path("/upload")
	@Consumes("multipart/form-data")
	@Produces(value = MediaType.APPLICATION_JSON)
	public List<Receita> uploadFile(final MultipartFormDataInput input) {

		String fileName = "";

		final Map<String,List<InputPart>> uploadForm = input.getFormDataMap();
		final List<InputPart> inputParts = uploadForm.get(NOME_CAMPO);

		for (final InputPart inputPart : inputParts) {

			try {

				fileName = new Date().getTime() + ".xls";

				final InputStream inputStream = inputPart.getBody(InputStream.class,null);

				final byte[] bytes = IOUtils.toByteArray(inputStream);

				final File file = new File(fileName);

				if (!file.exists()) {
					file.createNewFile();
				}

				final FileOutputStream fop = new FileOutputStream(file);

				fop.write(bytes);
				fop.flush();
				fop.close();

				return receitaFacade.carregarDeArquivo(file);

			} catch (final Exception e) {
				e.printStackTrace();
			}

		}

		return null;
	}

}
