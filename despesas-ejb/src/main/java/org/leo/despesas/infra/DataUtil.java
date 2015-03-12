package org.leo.despesas.infra;

import static java.util.Calendar.DAY_OF_MONTH;
import static java.util.Calendar.HOUR_OF_DAY;
import static java.util.Calendar.MILLISECOND;
import static java.util.Calendar.MINUTE;
import static java.util.Calendar.MONTH;
import static java.util.Calendar.SECOND;
import static java.util.Calendar.YEAR;

import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang3.time.DateUtils;

public class DataUtil extends DateUtils {

    private static List<Integer> FIELDS;

    static {
	FIELDS = new LinkedList<>();

	FIELDS.add(YEAR);
	FIELDS.add(MONTH);
	FIELDS.add(DAY_OF_MONTH);
	FIELDS.add(HOUR_OF_DAY);
	FIELDS.add(MINUTE);
	FIELDS.add(SECOND);
	FIELDS.add(MILLISECOND);
    }

    public static Date maximo(final Date date, final int field) {

	if (!FIELDS.contains(field)) {
	    throw new IllegalArgumentException("Field not valid!");
	}

	final Calendar calendar = Calendar.getInstance();
	calendar.setTime(date);

	for (int x = FIELDS.indexOf(field) + 1; x < FIELDS.size(); x++) {
	    calendar.set(FIELDS.get(x), calendar.getActualMaximum(FIELDS.get(x)));
	}

	return calendar.getTime();
    }

    public static Periodo getMesAtual() {
	return getMes(new Date());
    }

    public static Periodo getMes(Date dataBase) {

	final Date dataIncial = DataUtil.truncate(dataBase, Calendar.MONTH);
	final Date dataFinal = DataUtil.maximo(dataBase, Calendar.MONTH);

	return new Periodo(dataIncial, dataFinal);
    }
}