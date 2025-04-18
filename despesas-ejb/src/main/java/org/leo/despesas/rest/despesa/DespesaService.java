package org.leo.despesas.rest.despesa;

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
import javax.ws.rs.core.Response;

import org.apache.commons.io.IOUtils;
import org.jboss.resteasy.plugins.providers.multipart.InputPart;
import org.jboss.resteasy.plugins.providers.multipart.MultipartFormDataInput;
import org.leo.despesas.aplicacao.despesa.DespesaFacade;
import org.leo.despesas.dominio.movimentacao.Despesa;
import org.leo.despesas.dominio.movimentacao.DespesaFiltro;
import org.leo.despesas.infra.AbstractService;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.rest.DespesaVO;
import org.leo.despesas.rest.GraficoVO;

@Path("/despesa")
@RequestScoped
public class DespesaService extends AbstractService<DespesaFacade, Despesa, DespesaFiltro> {

	private static final String NOME_CAMPO = "arquivo";

	@EJB
	private DespesaFacade despesaFacade;

	@GET
	@Path(value = "/grafico")
	@Produces(MediaType.APPLICATION_JSON)
	public List<GraficoVO> buscarPorPeriodo(@QueryParam("dataInicial") final Date dataInicial, @QueryParam("dataFinal") final Date dataFinal) {
		return despesaFacade.getGraficoPorPeriodo(new Periodo(dataInicial, dataFinal));
	}

	@POST
	@Consumes(value = MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response inserir(final DespesaVO despesaVO) throws DespesasException {

		Despesa resultado = despesaFacade.inserir(despesaVO.getDespesa(), despesaVO.getParcelamentoVO());

		return Response.created(null).entity(resultado).build();
	}

	@Override
	public Response inserir(final Despesa t) {
		return Response.noContent().build();
	}

	@POST
	@Path(value = "/pagar")
	public void pagar(final Long id) throws DespesasException {
		despesaFacade.pagar(despesaFacade.buscarPorId(id));
	}

	@Override
	protected DespesaFacade getFacade() {
		return this.despesaFacade;
	}

	@POST
	@Path("/upload")
	@Consumes("multipart/form-data")
	@Produces(value = MediaType.APPLICATION_JSON)
	public List<Despesa> uploadFile(final MultipartFormDataInput input) {

		final Map<String, List<InputPart>> uploadForm = input.getFormDataMap();
		final List<InputPart> inputParts = uploadForm.get(NOME_CAMPO);

		for (final InputPart inputPart : inputParts) {

			try {

				final InputStream inputStream = inputPart.getBody(InputStream.class, null);

				final List<String> content = IOUtils.readLines(inputStream, StandardCharsets.UTF_8);

				return despesaFacade.carregarDeArquivo(content);

			} catch (final Exception e) {
				e.printStackTrace();
			}

		}

		return null;
	}

}
