package org.leo.despesas.infra.cotacao;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.io.IOUtils;

import com.google.common.base.Joiner;

public class CotacaoUrlParser {

	private static final String FORMATO = "name=\"currency2\" value=\"([0-9,]*)\"";

	public static BigDecimal getCotacao(String url) {

		try {

			URL endereco = new URL(url);

			HttpURLConnection con = (HttpURLConnection) endereco.openConnection();

			con.setRequestMethod("GET");

			String source = Joiner.on("").join(IOUtils.readLines(con.getInputStream(), StandardCharsets.UTF_8));
			
			return getCotacaoDe(source);

		} catch (IOException e) {

		}

		return null;
	}

	private static BigDecimal getCotacaoDe(String source) {
		
		Pattern pattern = Pattern.compile(FORMATO);
		
		Matcher matcher = pattern.matcher(source);
		
		if (matcher.find()){
			return new BigDecimal(matcher.group(1).replace(",", "."));
		}
		
		return null;
	}

}
