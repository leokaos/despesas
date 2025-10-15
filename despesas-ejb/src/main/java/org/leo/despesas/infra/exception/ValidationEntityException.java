package org.leo.despesas.infra.exception;

public class ValidationEntityException extends DespesasException {

	private static final long serialVersionUID = 4181848159677671539L;

	public ValidationEntityException() {
		super();
	}

	public ValidationEntityException(String message, Throwable cause) {
		super(message, cause);
	}

	public ValidationEntityException(String message) {
		super(message);
	}

	public ValidationEntityException(Throwable cause) {
		super(cause);
	}

}
