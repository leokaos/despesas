package org.leo.despesas.infra;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import com.github.tennaito.rsql.misc.DefaultArgumentParser;

public class CustomArgumentParser extends DefaultArgumentParser {

	@Override
	public <T> T parse(String argument, Class<T> type) {
		if (LocalDate.class.equals(type)) {
			return type.cast(LocalDate.parse(argument, DateTimeFormatter.ISO_LOCAL_DATE));
		}
		return super.parse(argument, type);
	}
}