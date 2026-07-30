package org.leo.despesas.dominio.alerta;

import java.time.LocalDate;

@FunctionalInterface
public interface TipoPeriodicidadeCalculator {

	LocalDate next(AlertaDespesaRecorrente alerta);

}
