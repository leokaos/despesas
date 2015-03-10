package org.leo.despesas.dominio.tipomovimentacao;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue(value = TipoDespesa.TIPO)
public class TipoDespesa extends TipoMovimentacao {

	public static final String TIPO = "D";

	public TipoDespesa() {
		super();
	}

}
