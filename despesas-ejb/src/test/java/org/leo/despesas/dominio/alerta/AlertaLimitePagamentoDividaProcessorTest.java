package org.leo.despesas.dominio.alerta;

import static org.easymock.EasyMock.capture;
import static org.easymock.EasyMock.expect;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.verify;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

import java.time.Clock;
import java.time.LocalDate;
import java.time.ZoneId;

import org.easymock.Capture;
import org.easymock.EasyMockRunner;
import org.easymock.Mock;
import org.easymock.MockType;
import org.easymock.TestSubject;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.leo.despesas.aplicacao.notificacao.NotificacaoFacade;
import org.leo.despesas.dominio.debitavel.Divida;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.notificacao.NotificacaoFiltro;
import org.leo.despesas.infra.util.DataUtil;

import com.google.common.collect.Lists;

@RunWith(EasyMockRunner.class)
public class AlertaLimitePagamentoDividaProcessorTest {

	@TestSubject
	private AlertaLimitePagamentoDividaProcessor processor = new AlertaLimitePagamentoDividaProcessor();

	@Mock(type = MockType.STRICT)
	private NotificacaoFacade mockNotificacaoFacade;

	@Before
	public void before() {
		DataUtil.setClock(Clock.fixed(LocalDate.of(2026, 1, 2).atStartOfDay(ZoneId.systemDefault()).toInstant(), ZoneId.systemDefault()));
	}

	@After
	public void after() {
		DataUtil.setClock(Clock.systemDefaultZone());
	}

	@Test
	public void deveriaNaoCriarNenhumaNotificacaoPoisExisteUmaAberta() throws Exception {

		Divida divida = new Divida();
		divida.setDescricao("Cartão");
		divida.setAtivo(true);
		divida.setDataLimite(LocalDate.of(2026, 1, 5));

		AlertaLimitePagamentoDivida alerta = new AlertaLimitePagamentoDivida();
		alerta.setDivida(divida);
		alerta.setDiasAntesDeAviso(10);

		Capture<NotificacaoFiltro> captureFiltro = new Capture<>();

		expect(mockNotificacaoFacade.listar(capture(captureFiltro))).andReturn(Lists.newArrayList(new Notificacao()));

		replay(mockNotificacaoFacade);

		processor.processarAlerta(alerta);

		verify(mockNotificacaoFacade);

		NotificacaoFiltro filtro = captureFiltro.getValue();

		assertEquals(alerta, filtro.getAlertaOrigem());
		assertFalse(filtro.isExecutado());
	}

	@Test
	public void deveriaCriarNotificacaoQuandoNaoExistirOutraAberta() throws Exception {

		Divida divida = new Divida();
		divida.setDescricao("Cartão");
		divida.setAtivo(true);
		divida.setDataLimite(LocalDate.of(2026, 1, 5));

		AlertaLimitePagamentoDivida alerta = new AlertaLimitePagamentoDivida();
		alerta.setDivida(divida);
		alerta.setDiasAntesDeAviso(10);

		Capture<NotificacaoFiltro> captureFiltro = new Capture<>();
		Capture<Notificacao> captureNotificacao = new Capture<>();

		expect(mockNotificacaoFacade.listar(capture(captureFiltro))).andReturn(Lists.newArrayList());
		expect(mockNotificacaoFacade.inserir(capture(captureNotificacao))).andReturn(new Notificacao());

		replay(mockNotificacaoFacade);

		processor.processarAlerta(alerta);

		verify(mockNotificacaoFacade);

		NotificacaoFiltro filtro = captureFiltro.getValue();

		assertEquals(alerta, filtro.getAlertaOrigem());
		assertFalse(filtro.isExecutado());

		Notificacao notificacao = captureNotificacao.getValue();

		assertEquals(alerta, notificacao.getAlerta());
		assertEquals(alerta.getDivida().getDataLimite(), notificacao.getTargetDate());
	}

	@Test
	public void deveriaNaoCriarNotificacaoQuandoDividaEstiverInativa() throws Exception {

		Divida divida = new Divida();
		divida.setAtivo(false);

		AlertaLimitePagamentoDivida alerta = new AlertaLimitePagamentoDivida();
		alerta.setDivida(divida);

		replay(mockNotificacaoFacade);

		processor.processarAlerta(alerta);

		verify(mockNotificacaoFacade);
	}

	@Test
	public void deveriaNaoCriarNotificacaoQuandoDataLimiteEstiverForaDoPrazo() throws Exception {

		Divida divida = new Divida();
		divida.setDescricao("Cartão");
		divida.setAtivo(true);
		divida.setDataLimite(LocalDate.of(2025, 3, 30));

		AlertaLimitePagamentoDivida alerta = new AlertaLimitePagamentoDivida();
		alerta.setDivida(divida);
		alerta.setDiasAntesDeAviso(10);

		replay(mockNotificacaoFacade);

		processor.processarAlerta(alerta);

		verify(mockNotificacaoFacade);
	}

}