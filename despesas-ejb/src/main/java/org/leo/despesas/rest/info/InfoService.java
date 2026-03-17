package org.leo.despesas.rest.info;

import javax.enterprise.context.RequestScoped;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/info")
@RequestScoped
public class InfoService {

	@GET
	@Produces(value = MediaType.APPLICATION_JSON)
	public String info() {
		return "ok";
	}

}
