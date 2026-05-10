package org.leo.despesas.rest.infra;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import org.leo.despesas.infra.exception.InvalidQueryException;

@Provider
public class InvalidQueryExceptionHandler implements ExceptionMapper<InvalidQueryException> {

	@Override
	public Response toResponse(InvalidQueryException exception) {
		return Response.status(Status.BAD_REQUEST).entity(exception.getMessage()).build();
	}
}
