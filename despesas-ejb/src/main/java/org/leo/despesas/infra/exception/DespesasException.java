package org.leo.despesas.infra.exception;

public class DespesasException extends Exception {

	private static final long serialVersionUID = 3558584349538303270L;

	public DespesasException() {
		super();
	}

	public DespesasException(String message,Throwable cause) {
		super(message,cause);
	}

	public DespesasException(String message) {
		super(message);
	}

	public DespesasException(Throwable cause) {
		super(cause);
	}

}
