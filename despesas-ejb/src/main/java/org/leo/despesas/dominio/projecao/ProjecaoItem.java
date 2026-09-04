package org.leo.despesas.dominio.projecao;

import java.math.BigDecimal;
import java.time.LocalDate;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@RequiredArgsConstructor
public class ProjecaoItem {

	private final LocalDate data;
	private final BigDecimal valor;

}
