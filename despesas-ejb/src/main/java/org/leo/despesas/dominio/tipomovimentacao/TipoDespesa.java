package org.leo.despesas.dominio.tipomovimentacao;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@DiscriminatorValue(value = TipoDespesa.TIPO)
@Getter
@Setter
@NoArgsConstructor
public class TipoDespesa extends TipoMovimentacao {

	private static final long serialVersionUID = -3849339550925045035L;

	public static final String TIPO = "D";

}
