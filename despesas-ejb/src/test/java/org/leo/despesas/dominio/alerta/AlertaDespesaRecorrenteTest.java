package org.leo.despesas.dominio.alerta;

import static org.junit.jupiter.api.Assertions.*;

import java.time.Clock;
import java.time.LocalDate;
import java.time.ZoneId;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.infra.util.DataUtil;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class AlertaDespesaRecorrenteTest {

	private AlertaDespesaRecorrente alerta;

	@BeforeEach
	void setUp() {
		alerta = new AlertaDespesaRecorrente();
		alerta.setTitulo("Aluguel");
		alerta.setDiaAlvo(15);
		alerta.setDiasAntesDeAviso(10);
	}

	@AfterEach
	void tearDown() {
		DataUtil.setClock(Clock.systemDefaultZone());
	}

	private void setClockAt(LocalDate data) {
		Clock clockFixo = Clock.fixed(data.atStartOfDay(ZoneId.systemDefault()).toInstant(), ZoneId.systemDefault());
		DataUtil.setClock(clockFixo);
	}

	@Test
	void deveriaGerarNotificacaoParaODiaUtilTest() {

		alerta.setTipoPeriodicidade(TipoPeriodicidade.DIA_UTIL);

		setClockAt(LocalDate.of(2026, 8, 10));

		LocalDate dataEsperada = LocalDate.of(2026, 8, 17);

		Notificacao notificacao = alerta.gerarNotificacao();

		assertNotNull(notificacao);
		assertEquals(alerta, notificacao.getAlerta());
		assertFalse(notificacao.isExecutado());
		assertEquals(dataEsperada, notificacao.getTargetDate());
	}

	@Test
	void deveriaGerarNotificacaoParaONoMaximoTest() {

		alerta.setTipoPeriodicidade(TipoPeriodicidade.NO_MAXIMO);

		setClockAt(LocalDate.of(2026, 8, 10));

		LocalDate dataEsperada = LocalDate.of(2026, 8, 14);

		Notificacao notificacao = alerta.gerarNotificacao();

		assertNotNull(notificacao);
		assertEquals(alerta, notificacao.getAlerta());
		assertFalse(notificacao.isExecutado());
		assertEquals(dataEsperada, notificacao.getTargetDate());
	}

	@Test
	void deveriarRetornarAMesmaDataMesmoTendoComoBaseDatasDiferentesTest() throws Exception {

		alerta.setTipoPeriodicidade(TipoPeriodicidade.DIA_UTIL);

		setClockAt(LocalDate.of(2026, 1, 10));
		assertEquals(LocalDate.of(2026, 1, 15), alerta.findProximaData());

		setClockAt(LocalDate.of(2026, 1, 11));
		assertEquals(LocalDate.of(2026, 1, 15), alerta.findProximaData());

		alerta.setTipoPeriodicidade(TipoPeriodicidade.NO_MAXIMO);

		setClockAt(LocalDate.of(2026, 1, 10));
		assertEquals(LocalDate.of(2026, 1, 15), alerta.findProximaData());

		setClockAt(LocalDate.of(2026, 1, 11));
		assertEquals(LocalDate.of(2026, 1, 15), alerta.findProximaData());
	}

	@Test
	void deveriaCalcularDentroDoAvisoTest() {

		setClockAt(LocalDate.of(2026, 1, 10));

		alerta.setDiaAlvo(15);
		alerta.setTipoPeriodicidade(TipoPeriodicidade.DIA_UTIL);

		assertTrue(alerta.isDentroDoTempoDeAviso());

		alerta.setTipoPeriodicidade(TipoPeriodicidade.NO_MAXIMO);

		assertTrue(alerta.isDentroDoTempoDeAviso());

		alerta.setDiaAlvo(30);
		alerta.setTipoPeriodicidade(TipoPeriodicidade.DIA_UTIL);

		assertFalse(alerta.isDentroDoTempoDeAviso());

		alerta.setTipoPeriodicidade(TipoPeriodicidade.NO_MAXIMO);

		assertFalse(alerta.isDentroDoTempoDeAviso());
	}
}