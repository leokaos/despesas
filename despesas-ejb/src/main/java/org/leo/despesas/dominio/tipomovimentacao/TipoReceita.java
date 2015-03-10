package org.leo.despesas.dominio.tipomovimentacao;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue(value = TipoReceita.TIPO)
public class TipoReceita extends TipoMovimentacao {

	public static final String TIPO = "R";

	public TipoReceita() {
		super();
	}

}
