package org.leo.despesas.aplicacao.alerta;

import static org.easymock.EasyMock.capture;
import static org.easymock.EasyMock.expect;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.verify;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.easymock.Capture;
import org.easymock.EasyMockRunner;
import org.easymock.Mock;
import org.easymock.MockType;
import org.easymock.TestSubject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.leo.despesas.aplicacao.notificacao.NotificacaoFacade;
import org.leo.despesas.dominio.alerta.Alerta;
import org.leo.despesas.dominio.alerta.AlertaDespesaRecorrente;
import org.leo.despesas.dominio.alerta.AlertaFiltro;
import org.leo.despesas.dominio.alerta.AlertaLimitePagamentoDivida;
import org.leo.despesas.dominio.alerta.AlertaPagamentoFaturaCartao;
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.debitavel.Divida;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.notificacao.NotificacaoFiltro;

@RunWith(EasyMockRunner.class)
public class AlertaJobTest {

	@TestSubject
	private AlertaJob job = new AlertaJob();

	@Mock(type = MockType.NICE)
	private AlertaFacade mockAlertaFacade;

	@Mock(type = MockType.NICE)
	private NotificacaoFacade mockNotificacaoFacade;

	@Test
	public void test() throws Exception {

		List<Alerta> data = new ArrayList<>();

		Divida divida = new Divida();
		divida.setDescricao("TEST DIVIDA");
		divida.setDataLimite(LocalDate.now().plusDays(10));

		CartaoCredito cartaoCredito = new CartaoCredito();
		cartaoCredito.setDescricao("TEST CARTAO");
		cartaoCredito.setDiaDeVencimento(10);

		AlertaLimitePagamentoDivida alerta1 = new AlertaLimitePagamentoDivida();
		alerta1.setDivida(divida);
		alerta1.setDiasAntesDeAviso(10);

		AlertaPagamentoFaturaCartao alerta2 = new AlertaPagamentoFaturaCartao();
		alerta2.setCartao(cartaoCredito);

		AlertaDespesaRecorrente alerta3 = new AlertaDespesaRecorrente();
		alerta3.setTitulo("Condominio");

		data.add(alerta1);
		data.add(alerta2);
		data.add(alerta3);

		Capture<AlertaFiltro> captureAlertaFiltro = new Capture<AlertaFiltro>();
		Capture<NotificacaoFiltro> captureNotificacaoFiltro = new Capture<NotificacaoFiltro>();
		Capture<Notificacao> captureNotificacao = new Capture<Notificacao>();

		expect(mockAlertaFacade.listar(capture(captureAlertaFiltro))).andReturn(data);
		expect(mockNotificacaoFacade.listar(capture(captureNotificacaoFiltro))).andReturn(new ArrayList<>()).times(3);

		expect(mockNotificacaoFacade.inserir(capture(captureNotificacao))).andReturn(new Notificacao()).once();

		replay(mockAlertaFacade, mockNotificacaoFacade);

		job.executar();

		verify(mockAlertaFacade, mockNotificacaoFacade);

		assertEquals(alerta1, captureNotificacao.getValue().getAlerta());
		assertFalse(captureNotificacao.getValue().isExecutado());

	}

}
