package org.leo.despesas.rest.projecao;

import javax.ejb.EJB;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.leo.despesas.aplicacao.projecao.ProjecaoFacade;
import org.leo.despesas.dominio.projecao.Projecao;
import org.leo.despesas.infra.exception.DespesasException;

@Path("projecao")
public class ProjecaoService {

	@EJB
	private ProjecaoFacade projecaoFacade;

	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Projecao createProjecao(ProjecaoVO vo) throws DespesasException {
		return projecaoFacade.criarProjecao(vo.getDebitavel(), vo.getPeriodo());
	}
}
