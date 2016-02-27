package org.leo.despesas.rest.infra;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import org.leo.despesas.infra.exception.NotFoundEntityException;

@Provider
public class NotFoundEntityExceptionHandler implements ExceptionMapper<NotFoundEntityException> {

	@Override
	public Response toResponse(NotFoundEntityException exception) {
		return Response.status(Status.NOT_FOUND).build();
	}
}
