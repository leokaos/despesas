package org.leo.despesas.dominio.projecao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.google.common.collect.Lists;

public class Projecao {

	private List<ProjecaoItem> itens = Lists.newArrayList();

	public Projecao() {
		super();
	}

	public List<ProjecaoItem> getItens() {
		return itens;
	}

	public void setItens(List<ProjecaoItem> itens) {
		this.itens = itens;
	}

	public void addItem(Date date, BigDecimal saldo) {
		itens.add(new ProjecaoItem(date, saldo));
	}

}
