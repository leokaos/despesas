package org.leo.despesas.dominio.servicotransferencia;

import java.util.Calendar;
import java.util.Date;

import javax.ws.rs.QueryParam;

import org.apache.commons.lang3.time.DateUtils;
import org.leo.despesas.infra.AbstractModelFiltro;
import org.leo.despesas.infra.Moeda;

public class CotacaoFiltro extends AbstractModelFiltro<Cotacao> {

	@QueryParam("origem")
	private Moeda origem;

	@QueryParam("destino")
	private Moeda destino;

	@QueryParam("data")
	private Date data;

	public CotacaoFiltro() {
		super();
	}

	@Override
	protected void build() {

		eq("destino", destino);

		eq("origem", origem);

		if (data != null) {

			Date inicio = DateUtils.truncate(data, Calendar.DAY_OF_MONTH);
			Date fim = DateUtils.addSeconds(DateUtils.truncate(DateUtils.addDays(data, 1), Calendar.DAY_OF_MONTH), -1);

			between("data", inicio, fim);

		}
	}
}
