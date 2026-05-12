package org.leo.despesas.rest.debitavel;

import java.util.List;

import javax.ejb.EJB;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.jboss.resteasy.annotations.Form;
import org.leo.despesas.aplicacao.debitavel.DebitavelFacade;
import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.debitavel.DebitavelFiltro;

@Path("/debitavel")
public class DebitavelService {

	@EJB
	private DebitavelFacade debitavelFacade;

	@GET
	@Produces(value = MediaType.APPLICATION_JSON)
	public List<Debitavel> listar(@Form DebitavelFiltro filtro){
		return debitavelFacade.listar(filtro);
	}
}
