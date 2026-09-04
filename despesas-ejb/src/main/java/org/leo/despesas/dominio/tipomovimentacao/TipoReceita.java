package org.leo.despesas.dominio.tipomovimentacao;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@DiscriminatorValue(value = TipoReceita.TIPO)
@Getter
@Setter
@NoArgsConstructor
public class TipoReceita extends TipoMovimentacao {

	private static final long serialVersionUID = 6450954975135961031L;

	public static final String TIPO = "R";

}
