package org.leo.despesas.infra.exception;

public class UpdateEntityMismatchException extends DespesasException {

	private static final long serialVersionUID = 4181848159677671539L;

	public UpdateEntityMismatchException() {
		super();
	}

	public UpdateEntityMismatchException(String message, Throwable cause) {
		super(message, cause);
	}

	public UpdateEntityMismatchException(String message) {
		super(message);
	}

	public UpdateEntityMismatchException(Throwable cause) {
		super(cause);
	}

}
