package org.leo.despesas.dominio.alerta;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
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
import org.leo.despesas.dominio.debitavel.Divida;
import org.leo.despesas.dominio.notificacao.Notificacao;
import org.leo.despesas.dominio.notificacao.NotificacaoFiltro;
import org.leo.despesas.infra.util.DataUtil;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.google.common.collect.Lists;

@ExtendWith(MockitoExtension.class)
public class AlertaLimitePagamentoDividaProcessorTest {

	@InjectMocks
	private AlertaLimitePagamentoDividaProcessor processor = new AlertaLimitePagamentoDividaProcessor();

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
	public void deveriaNaoCriarNenhumaNotificacaoPoisExisteUmaAberta() throws Exception {

		Divida divida = new Divida();
		divida.setDescricao("Cartão");
		divida.setAtivo(true);
		divida.setDataLimite(LocalDate.of(2026, 1, 5));

		AlertaLimitePagamentoDivida alerta = new AlertaLimitePagamentoDivida();
		alerta.setDivida(divida);
		alerta.setDiasAntesDeAviso(10);

		ArgumentCaptor<NotificacaoFiltro> captureFiltro = ArgumentCaptor.forClass(NotificacaoFiltro.class);

		when(mockNotificacaoFacade.listar(any(NotificacaoFiltro.class))).thenReturn(Lists.newArrayList(new Notificacao()));

		processor.processarAlerta(alerta);

		verify(mockNotificacaoFacade).listar(captureFiltro.capture());

		NotificacaoFiltro filtro = captureFiltro.getValue();

		assertEquals(alerta, filtro.getAlertaOrigem());
		assertFalse(filtro.getExecutado());
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

		ArgumentCaptor<NotificacaoFiltro> captureFiltro = ArgumentCaptor.forClass(NotificacaoFiltro.class);
		ArgumentCaptor<Notificacao> captureNotificacao = ArgumentCaptor.forClass(Notificacao.class);

		when(mockNotificacaoFacade.listar(any(NotificacaoFiltro.class))).thenReturn(Lists.newArrayList());
		when(mockNotificacaoFacade.inserir(any(Notificacao.class))).thenReturn(new Notificacao());

		processor.processarAlerta(alerta);

		verify(mockNotificacaoFacade).listar(captureFiltro.capture());
		verify(mockNotificacaoFacade).inserir(captureNotificacao.capture());

		NotificacaoFiltro filtro = captureFiltro.getValue();

		assertEquals(alerta, filtro.getAlertaOrigem());
		assertFalse(filtro.getExecutado());

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

		processor.processarAlerta(alerta);

		verifyNoInteractions(mockNotificacaoFacade);
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

		processor.processarAlerta(alerta);

		verifyNoInteractions(mockNotificacaoFacade);
	}

}