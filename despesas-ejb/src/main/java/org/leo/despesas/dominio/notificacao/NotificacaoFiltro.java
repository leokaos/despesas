package org.leo.despesas.dominio.notificacao;

import java.time.LocalDate;

import javax.ws.rs.QueryParam;

import org.leo.despesas.dominio.alerta.Alerta;
import org.leo.despesas.infra.AbstractModelFiltro;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class NotificacaoFiltro extends AbstractModelFiltro<Notificacao> {

	private Alerta alertaOrigem;

	@QueryParam("executado")
	private Boolean executado;

	private LocalDate targetDate;

	@Override
	protected void build() {

		eq("alerta", alertaOrigem);

		eq("executado", executado);

		eq("targetDate", targetDate);
	}

}
