package org.leo.despesas.dominio.alerta;

import static org.easymock.EasyMock.capture;
import static org.easymock.EasyMock.expect;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.verify;
import static org.junit.Assert.assertEquals;

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
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.notificacao.NotificacaoFiltro;
import org.leo.despesas.infra.util.DataUtil;

import com.google.common.collect.Lists;

@RunWith(EasyMockRunner.class)
public class AlertaPagamentoFaturaCartaoProcessorTest {

	@TestSubject
	private AlertaPagamentoFaturaCartaoProcessor processor = new AlertaPagamentoFaturaCartaoProcessor();

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
	public void deveriaNaoCriarNenhumaNotificacaoPoisExisteUmaAbertaTest() throws Exception {

		AlertaPagamentoFaturaCartao alerta = createNewAlerta();

		Capture<NotificacaoFiltro> captureNotificacaoFiltro = new Capture<NotificacaoFiltro>();
		expect(mockNotificacaoFacade.listar(capture(captureNotificacaoFiltro))).andReturn(Lists.newArrayList(new Notificacao()));

		replay(mockNotificacaoFacade);

		processor.processarAlerta(alerta);

		verify(mockNotificacaoFacade);

		NotificacaoFiltro filtro = captureNotificacaoFiltro.getValue();

		assertEquals(alerta, filtro.getAlertaOrigem());
		assertEquals(LocalDate.of(2026, 1, 8), filtro.getTargetDate());
	}

	@Test
	public void deveriaNaoCriarNenhumaNotificacaoPoisAindaNaoEstaPertoTest() throws Exception {

		AlertaPagamentoFaturaCartao alerta = createNewAlerta();
		alerta.setDiasAntesDeAviso(4);

		replay(mockNotificacaoFacade);

		processor.processarAlerta(alerta);

		verify(mockNotificacaoFacade);

	}

	private AlertaPagamentoFaturaCartao createNewAlerta() {

		CartaoCredito cartao = new CartaoCredito();
		cartao.setAtivo(true);
		cartao.setDiaDeVencimento(8);

		AlertaPagamentoFaturaCartao alerta = new AlertaPagamentoFaturaCartao();
		alerta.setCartao(cartao);
		alerta.setDiasAntesDeAviso(10);

		return alerta;
	}

}