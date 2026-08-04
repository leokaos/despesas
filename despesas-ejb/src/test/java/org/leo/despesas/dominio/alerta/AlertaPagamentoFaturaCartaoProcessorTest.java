package org.leo.despesas.dominio.alerta;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

import java.time.Clock;
import java.time.LocalDate;
import java.time.ZoneId;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.leo.despesas.aplicacao.notificacao.NotificacaoFacade;
import org.leo.despesas.dominio.debitavel.CartaoCredito;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.notificacao.NotificacaoFiltro;
import org.leo.despesas.infra.util.DataUtil;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.google.common.collect.Lists;

@ExtendWith(MockitoExtension.class)
public class AlertaPagamentoFaturaCartaoProcessorTest {

	@InjectMocks
	private AlertaPagamentoFaturaCartaoProcessor processor = new AlertaPagamentoFaturaCartaoProcessor();

	@Mock
	private NotificacaoFacade mockNotificacaoFacade;

	@BeforeEach
	public void before() {
		DataUtil.setClock(Clock.fixed(LocalDate.of(2026, 1, 2).atStartOfDay(ZoneId.systemDefault()).toInstant(), ZoneId.systemDefault()));
	}

	@AfterEach
	public void after() {
		DataUtil.setClock(Clock.systemDefaultZone());
	}

	@Test
	public void deveriaNaoCriarNenhumaNotificacaoPoisExisteUmaAbertaTest() throws Exception {

		AlertaPagamentoFaturaCartao alerta = createNewAlerta();

		ArgumentCaptor<NotificacaoFiltro> captureNotificacaoFiltro = ArgumentCaptor.forClass(NotificacaoFiltro.class);
		when(mockNotificacaoFacade.listar(any(NotificacaoFiltro.class))).thenReturn(Lists.newArrayList(new Notificacao()));

		processor.processarAlerta(alerta);

		verify(mockNotificacaoFacade).listar(captureNotificacaoFiltro.capture());

		NotificacaoFiltro filtro = captureNotificacaoFiltro.getValue();

		assertEquals(alerta, filtro.getAlertaOrigem());
		assertEquals(LocalDate.of(2026, 1, 8), filtro.getTargetDate());
	}

	@Test
	public void deveriaNaoCriarNenhumaNotificacaoPoisAindaNaoEstaPertoTest() throws Exception {

		AlertaPagamentoFaturaCartao alerta = createNewAlerta();
		alerta.setDiasAntesDeAviso(4);

		processor.processarAlerta(alerta);

		verifyNoInteractions(mockNotificacaoFacade);
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