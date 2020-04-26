package org.leo.despesas.dominio.debitavel;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.leo.despesas.infra.Moeda;
import org.leo.despesas.rest.DebitavelSerializerVisitorImpl;

public class DebitavelFactory {

	private static Map<String, Class<? extends Debitavel>> mapaValores;

	static {
		mapaValores = new HashMap<String, Class<? extends Debitavel>>();

		mapaValores.put(Conta.CODIGO_TIPO, Conta.class);
		mapaValores.put(CartaoCredito.CODIGO_TIPO, CartaoCredito.class);
		mapaValores.put(Investimento.CODIGO_TIPO, Investimento.class);
	}

	public static Debitavel parse(Map<String, String> mapaAtributos) {

		String tipoDebitavel = mapaAtributos.get("tipo");

		Debitavel debitavel = getNewInstance(tipoDebitavel);

		if (mapaAtributos.get("id") != null) {
			debitavel.setId(Long.valueOf(mapaAtributos.get("id")));
		}

		debitavel.setCor(mapaAtributos.get("cor"));
		debitavel.setDescricao(mapaAtributos.get("descricao"));
		debitavel.setMoeda(Moeda.valueOf(mapaAtributos.get("moeda")));

		debitavel.accept(new DebitavelSerializerVisitorImpl(mapaAtributos));

		return debitavel;
	}

	private static Debitavel getNewInstance(String tipoDebitavel) {

		try {

			Iterator<Entry<String, Class<? extends Debitavel>>> iterator = mapaValores.entrySet().iterator();

			while (iterator.hasNext()) {
				Entry<String, Class<? extends Debitavel>> entry = iterator.next();

				if (entry.getKey().equals(tipoDebitavel)) {
					return entry.getValue().newInstance();
				}
			}

			return null;

		} catch (Exception ex) {
			return null;
		}
	}
}
