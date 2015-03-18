package org.leo.despesas.rest.orcamento;

import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.leo.despesas.aplicacao.orcamento.OrcamentoFacade;
import org.leo.despesas.dominio.orcamento.Orcamento;
import org.leo.despesas.dominio.orcamento.OrcamentoFiltro;
import org.leo.despesas.infra.DataUtil;
import org.leo.despesas.infra.Periodo;
import org.leo.despesas.rest.infra.AbstractService;

@Path("/orcamento")
@RequestScoped
public class OrcamentoService extends AbstractService<OrcamentoFacade, Orcamento> {

	@EJB
	private OrcamentoFacade orcamentoFacade;

	@Override
	protected OrcamentoFacade getFacade() {
		return this.orcamentoFacade;
	}

	@POST
	@Path(value = "/filtro")
	@Consumes(MediaType.APPLICATION_JSON)
	public List<Orcamento> buscarPorFiltro(OrcamentoFiltro filtro) {
		return orcamentoFacade.buscarPorFiltro(filtro);
	}

	@GET
	@Path(value = "/data")
	public Orcamento buscarPorData(@QueryParam("vencimento") Date vencimento, @QueryParam("tipoDespesa") String tipoDespesa) {

		Periodo periodo = DataUtil.getMes(vencimento);
		OrcamentoFiltro filtro = new OrcamentoFiltro();

		filtro.setDataInicial(periodo.getDataInicial());
		filtro.setDataFinal(periodo.getDataFinal());
		filtro.setTipoDespesa(tipoDespesa);

		List<Orcamento> orcamentos = orcamentoFacade.buscarPorFiltro(filtro);

		if (orcamentos.size() > 1) {
			return null;
		}

		return orcamentos.iterator().next();
	}

}
