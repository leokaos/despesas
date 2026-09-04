package org.leo.despesas.dominio.projecao;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import com.google.common.collect.Lists;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Projecao implements Serializable {

	private static final long serialVersionUID = -3806316926897965193L;

	private List<ProjecaoItem> itens = Lists.newArrayList();

	public void addItem(LocalDate date, BigDecimal saldo) {
		itens.add(new ProjecaoItem(date, saldo));
	}

}
