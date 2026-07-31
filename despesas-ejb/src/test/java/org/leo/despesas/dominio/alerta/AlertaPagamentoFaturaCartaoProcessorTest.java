package org.leo.despesas.dominio.alerta;

import static org.easymock.EasyMock.capture;
import static org.easymock.EasyMock.expect;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.verify;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

import java.time.LocalDate;

import org.easymock.Capture;
import org.easymock.EasyMockRunner;
import org.easymock.Mock;
import org.easymock.MockType;
import org.easymock.TestSubject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.leo.despesas.aplicacao.notificacao.NotificacaoFacade;
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.notificacao.NotificacaoFiltro;
import org.leo.despesas.infra.Mes;

import com.google.common.collect.Lists;

@RunWith(EasyMockRunner.class)
public class AlertaPagamentoFaturaCartaoProcessorTest {

	@TestSubject
	private AlertaPagamentoFaturaCartaoProcessor processor = new AlertaPagamentoFaturaCartaoProcessor();

	@Mock(type = MockType.STRICT)
	private NotificacaoFacade mockNotificacaoFacade;

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
		assertFalse(filtro.isExecutado());
		assertEquals(Mes.mesAtual(), filtro.getMes());
	}

	private AlertaPagamentoFaturaCartao createNewAlerta() {

		CartaoCredito cartao = new CartaoCredito();
		cartao.setAtivo(true);
		cartao.setDiaDeVencimento(LocalDate.now().getDayOfMonth());

		AlertaPagamentoFaturaCartao alerta = new AlertaPagamentoFaturaCartao();
		alerta.setCartao(cartao);
		alerta.setDiasAntesDeAviso(10);

		return alerta;
	}

}