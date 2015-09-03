package org.leo.despesas.dominio.tipomovimentacao;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue(value = TipoDespesa.TIPO)
public class TipoDespesa extends TipoMovimentacao {

	private static final long serialVersionUID = -3849339550925045035L;

	public static final String TIPO = "D";

	public TipoDespesa() {
		super();
	}

}
