package org.leo.despesas.dominio.servicotransferencia;

import javax.ws.rs.QueryParam;

import org.leo.despesas.infra.AbstractModelFiltro;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ServicoTransferenciaFiltro extends AbstractModelFiltro<ServicoTransferencia> {

	@QueryParam("nome")
	private String nome;

	@Override
	protected void build() {
		like("nome", nome);
	}

}
