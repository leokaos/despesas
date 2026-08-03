package org.leo.despesas.dominio.alerta;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.time.Clock;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.stream.Stream;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

import org.leo.despesas.infra.util.DataUtil;

class TipoPeriodicidadeTest {

	private static final ZoneId ZONE = ZoneId.systemDefault();
	private static final Clock CLOCK_ORIGINAL = DataUtil.CLOCK;
	private static final LocalDate BASE = LocalDate.of(2026, 1, 1);

	@BeforeEach
	void fixarRelogio() {
		DataUtil.CLOCK = Clock.fixed(BASE.atStartOfDay(ZONE).toInstant(), ZONE);
	}

	@AfterEach
	void restaurarRelogio() {
		DataUtil.CLOCK = CLOCK_ORIGINAL;
	}

	static Stream<Arguments> casosDiaUtil() {
		return Stream.of(
				Arguments.of(1, LocalDate.of(2026, 1, 1)),
				Arguments.of(3, LocalDate.of(2026, 1, 5)),
				Arguments.of(4, LocalDate.of(2026, 1, 5)),
				Arguments.of(10, LocalDate.of(2026, 1, 12)),
				Arguments.of(15, LocalDate.of(2026, 1, 15)),
				Arguments.of(31, LocalDate.of(2026, 2, 2)));
	}

	@ParameterizedTest(name = "diaAlvo={0} -> esperado={1}")
	@MethodSource("casosDiaUtil")
	void deveCalcularDiaUtil(int diaAlvo, LocalDate esperado) {
		LocalDate resultado = TipoPeriodicidade.DIA_UTIL.getCalculator().apply(diaAlvo);
		assertEquals(esperado, resultado);
	}

	static Stream<Arguments> casosNoMaximo() {
		return Stream.of(
				Arguments.of(1, LocalDate.of(2026, 1, 1)),
				Arguments.of(3, LocalDate.of(2026, 1, 2)),
				Arguments.of(4, LocalDate.of(2026, 1, 2)),
				Arguments.of(10, LocalDate.of(2026, 1, 9)),
				Arguments.of(15, LocalDate.of(2026, 1, 15)),
				Arguments.of(31, LocalDate.of(2026, 1, 30)));
	}

	@ParameterizedTest(name = "diaAlvo={0} -> esperado={1}")
	@MethodSource("casosNoMaximo")
	void deveCalcularNoMaximo(int diaAlvo, LocalDate esperado) {
		LocalDate resultado = TipoPeriodicidade.NO_MAXIMO.getCalculator().apply(diaAlvo);
		assertEquals(esperado, resultado);
	}
}