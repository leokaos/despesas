package org.leo.despesas.infra.exception;

public class NotFoundEntityException extends DespesasException {

	private static final long serialVersionUID = -2755054707970340580L;

	public NotFoundEntityException() {
		super();
	}

	public NotFoundEntityException(String message,Throwable cause) {
		super(message,cause);
	}

	public NotFoundEntityException(String message) {
		super(message);
	}

	public NotFoundEntityException(Throwable cause) {
		super(cause);
	}

}
