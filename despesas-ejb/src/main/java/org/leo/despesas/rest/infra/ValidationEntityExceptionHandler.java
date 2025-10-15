package org.leo.despesas.rest.infra;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import org.leo.despesas.infra.exception.ValidationEntityException;

@Provider
public class ValidationEntityExceptionHandler implements ExceptionMapper<ValidationEntityException> {

	@Override
	public Response toResponse(ValidationEntityException exception) {
		return Response.status(Status.BAD_REQUEST).entity(exception.getMessage()).build();
	}

}
