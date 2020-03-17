package org.leo.despesas.rest;

import java.io.Serializable;
import java.math.BigDecimal;

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.leo.despesas.dominio.parcelamento.Parcelamento;

@JsonDeserialize(using = ParcelamentoVODeserializer.class)
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
