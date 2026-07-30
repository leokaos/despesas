package org.leo.despesas.dominio.alerta;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Table;

import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.infra.alerta.AlertaProcessorVisitor;

@Entity
@Table(name = "alerta_despesa_recorrente", schema = "despesas_db")
public class AlertaDespesaRecorrente extends Alerta {

	private static final long serialVersionUID = -5282519238519370892L;

	@Column(name = "titulo")
	private String titulo;

	@Enumerated(EnumType.STRING)
	@Column(name = "tipo_periodicidade")
	private TipoPeriodicidade tipoPeriodicidade;

	@Column(name = "dia_alvo")
	private int diaAlvo;

	public AlertaDespesaRecorrente() {
		super();
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public TipoPeriodicidade getTipoPeriodicidade() {
		return tipoPeriodicidade;
	}

	public void setTipoPeriodicidade(TipoPeriodicidade tipoPeriodicidade) {
		this.tipoPeriodicidade = tipoPeriodicidade;
	}

	public int getDiaAlvo() {
		return diaAlvo;
	}

	public void setDiaAlvo(int diaAlvo) {
		this.diaAlvo = diaAlvo;
	}

	public boolean isDentroDoTempoDeAviso() {

		LocalDate minimaDataParaAvisar = tipoPeriodicidade.getCalculator().next(this).minusDays(diasAntesDeAviso);

		return minimaDataParaAvisar.isEqual(LocalDate.now()) || minimaDataParaAvisar.isAfter(LocalDate.now());
	}

	@Override
	public Notificacao gerarNotificacao() {

		LocalDate targetDate = tipoPeriodicidade.getCalculator().next(this);

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
