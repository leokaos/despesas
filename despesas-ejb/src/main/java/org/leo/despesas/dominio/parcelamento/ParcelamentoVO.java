package org.leo.despesas.dominio.parcelamento;

import java.io.Serializable;
import java.math.BigDecimal;

import org.codehaus.jackson.map.annotate.JsonDeserialize;

@JsonDeserialize(using = ParcelamentoVODeserialize.class)
public class ParcelamentoVO implements Serializable {

	private static final long serialVersionUID = -506071545322037530L;

	private final Parcelamento tipoParcelamento;
	private final BigDecimal numeroParcelas;

	public ParcelamentoVO(Parcelamento tipoParcelamento,BigDecimal numeroParcelas) {
		super();
		this.tipoParcelamento = tipoParcelamento;
		this.numeroParcelas = numeroParcelas;
	}

	public Parcelamento getTipoParcelamento() {
		return tipoParcelamento;
	}

	public BigDecimal getNumeroParcelas() {
		return numeroParcelas;
	}

}
