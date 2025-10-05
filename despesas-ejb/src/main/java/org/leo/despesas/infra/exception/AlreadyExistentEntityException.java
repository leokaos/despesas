package org.leo.despesas.infra.exception;

public class AlreadyExistentEntityException extends DespesasException {

	private static final long serialVersionUID = 4181848159677671539L;

	public AlreadyExistentEntityException() {
		super();
	}

	public AlreadyExistentEntityException(String message, Throwable cause) {
		super(message, cause);
	}

	public AlreadyExistentEntityException(String message) {
		super(message);
	}

	public AlreadyExistentEntityException(Throwable cause) {
		super(cause);
	}

}
