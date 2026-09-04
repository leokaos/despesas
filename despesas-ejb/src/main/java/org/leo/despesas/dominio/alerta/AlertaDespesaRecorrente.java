package org.leo.despesas.dominio.alerta;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Table;

import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.infra.alerta.AlertaProcessorVisitor;
import org.leo.despesas.infra.util.DataUtil;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "alerta_despesa_recorrente", schema = "despesas_db")
@Getter
@Setter
@NoArgsConstructor
public class AlertaDespesaRecorrente extends Alerta {

	private static final long serialVersionUID = -5282519238519370892L;

	@Column(name = "titulo")
	private String titulo;

	@Enumerated(EnumType.STRING)
	@Column(name = "tipo_periodicidade")
	private TipoPeriodicidade tipoPeriodicidade;

	@Column(name = "dia_alvo")
	private int diaAlvo;

	public LocalDate findProximaData() {
		return tipoPeriodicidade.getCalculator().apply(diaAlvo);
	}

	public boolean isDentroDoTempoDeAviso() {

		LocalDate dataAlvo = tipoPeriodicidade.getCalculator().apply(diaAlvo);

		return DataUtil.estaNosProximosDias(dataAlvo, diasAntesDeAviso);
	}

	@Override
	public Notificacao gerarNotificacao() {

		LocalDate targetDate = tipoPeriodicidade.getCalculator().apply(diaAlvo);

		Notificacao notificacao = new Notificacao();
		notificacao.setAlerta(this);
		notificacao.setExecutado(false);
		notificacao.setTargetDate(targetDate);

		return notificacao;
	}

	@Override
	public String getDescricao() {
		return titulo;
	}

	@Override
	public void accept(AlertaProcessorVisitor visitor) {
		visitor.visit(this);
	}

}
