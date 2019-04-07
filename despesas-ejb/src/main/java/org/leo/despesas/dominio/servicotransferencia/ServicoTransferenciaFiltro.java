package org.leo.despesas.dominio.servicotransferencia;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;

public class ServicoTransferenciaFiltro extends AbstractModelFiltro<ServicoTransferencia> {

	@QueryParam("nome")
	private String nome;

	public ServicoTransferenciaFiltro() {
		super();
	}

	@Override
	protected void build() {
		like("nome", nome);
	}

}
