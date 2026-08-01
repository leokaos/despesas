package org.leo.despesas.dominio.alerta;

import static org.leo.despesas.dominio.alerta.TipoAlerta.DESPESA_RECORRENTE;
import static org.leo.despesas.dominio.alerta.TipoAlerta.FATURA_CARTAO_CREDITO;

import java.util.HashMap;
import java.util.Map;

public class AlertaFactory {

	private static Map<TipoAlerta, Class<? extends Alerta>> mapaValores;

	static {
		mapaValores = new HashMap<>();

		mapaValores.put(DESPESA_RECORRENTE, AlertaDespesaRecorrente.class);
		mapaValores.put(FATURA_CARTAO_CREDITO, AlertaPagamentoFaturaCartao.class);
		mapaValores.put(TipoAlerta.VALOR_LIMITE_DIVIDA, AlertaPagamentoFaturaCartao.class);
	}

	public static Alerta parse(Map<String, String> mapaAtributos) {

		String tipo = mapaAtributos.get("tipo");

		Alerta alerta = getNewInstance(tipo);

		if (mapaAtributos.get("id") != null) {
			alerta.setId(Long.valueOf(mapaAtributos.get("id")));
		}

		alerta.setTipo(TipoAlerta.valueOf(tipo));
		alerta.setDiasAntesDeAviso(Integer.valueOf(mapaAtributos.get("diasAntesDeAviso")));

		return alerta;
	}

	private static Alerta getNewInstance(String tipo) {
		try {
			return mapaValores.get(TipoAlerta.valueOf(tipo)).newInstance();
		} catch (Exception ex) {
			return null;
		}
	}

}
