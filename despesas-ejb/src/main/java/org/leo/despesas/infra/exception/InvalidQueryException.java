package org.leo.despesas.infra.exception;

public class InvalidQueryException extends RuntimeException {

	private static final long serialVersionUID = 6030841287872129906L;

	public InvalidQueryException() {
		super();
	}

	public InvalidQueryException(String message, Throwable cause) {
		super(message, cause);
	}

	public InvalidQueryException(String message) {
		super(message);
	}

	public InvalidQueryException(Throwable cause) {
		super(cause);
	}

}
