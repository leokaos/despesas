package org.leo.despesas.services;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.Response.Status;

import org.leo.despesas.aplicacao.full.search.FullSearchFacade;
import org.leo.despesas.infra.exception.DespesasException;

@WebServlet(value = "/index", loadOnStartup = 1)
public class ConfigSearchServlet extends HttpServlet {

	private static final long serialVersionUID = 791093768975367026L;

	@EJB
	private FullSearchFacade facade;

	public ConfigSearchServlet() {
		super();
	}

	@Override
	public void init() throws ServletException {

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			facade.initIndex();
		} catch (DespesasException e) {
			response.setStatus(Status.INTERNAL_SERVER_ERROR.getStatusCode());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
