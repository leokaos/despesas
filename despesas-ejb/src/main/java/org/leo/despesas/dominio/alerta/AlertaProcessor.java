package org.leo.despesas.dominio.alerta;

public interface AlertaProcessor<T extends Alerta> {

	void processarAlerta(T alerta);

}
