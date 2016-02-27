package org.leo.despesas.rest.infra;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;

import org.leo.despesas.infra.exception.AlreadyExistentEntityException;

public class AlreadyExistentEntityExceptionHandler implements ExceptionMapper<AlreadyExistentEntityException> {

	@Override
	public Response toResponse(AlreadyExistentEntityException exception) {
		return Response.status(Status.CONFLICT).build();
	}

}
