package org.leo.despesas.rest.receita;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
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

import org.apache.commons.io.IOUtils;
import org.jboss.resteasy.plugins.providers.multipart.InputPart;
import org.jboss.resteasy.plugins.providers.multipart.MultipartFormDataInput;
import org.leo.despesas.aplicacao.receita.ReceitaFacade;
import org.leo.despesas.dominio.movimentacao.Receita;
import org.leo.despesas.dominio.movimentacao.ReceitaFiltro;
import org.leo.despesas.infra.AbstractService;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.rest.GraficoVO;

@Path("/receita")
@RequestScoped
public class ReceitaService extends AbstractService<ReceitaFacade, Receita, ReceitaFiltro> {

	private static final String NOME_CAMPO = "arquivo";

	@EJB
	private ReceitaFacade receitaFacade;

	@GET
	@Path(value = "/grafico")
	@Produces(MediaType.APPLICATION_JSON)
	public List<GraficoVO> buscarPorPeriodo(@QueryParam("dataInicial") final Date dataInicial, @QueryParam("dataFinal") final Date dataFinal) {
		return receitaFacade.getGraficoPorPeriodo(new Periodo(dataInicial, dataFinal));
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

		final Map<String, List<InputPart>> uploadForm = input.getFormDataMap();
		final List<InputPart> inputParts = uploadForm.get(NOME_CAMPO);

		for (final InputPart inputPart : inputParts) {

			try {

				final InputStream inputStream = inputPart.getBody(InputStream.class, null);

				final List<String> content = IOUtils.readLines(inputStream, StandardCharsets.UTF_8);

				return receitaFacade.carregarDeArquivo(content);

			} catch (final Exception e) {
				e.printStackTrace();
			}

		}

		return null;
	}

}
