package org.leo.despesas.rest.infra;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import org.leo.despesas.infra.exception.AlreadyExistentEntityException;

@Provider
public class AlreadyExistentEntityExceptionHandler implements ExceptionMapper<AlreadyExistentEntityException> {

	@Override
	public Response toResponse(AlreadyExistentEntityException exception) {
		return Response.status(Status.CONFLICT).entity(exception.getMessage()).build();
	}

}
