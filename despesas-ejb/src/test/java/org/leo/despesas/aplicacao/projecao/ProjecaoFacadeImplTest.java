package org.leo.despesas.aplicacao.projecao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.util.Date;

import org.apache.commons.lang3.time.DateUtils;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.leo.despesas.aplicacao.debitavel.DebitavelFacade;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.projecao.Projecao;
import org.leo.despesas.infra.Periodo;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class ProjecaoFacadeImplTest {

	@InjectMocks
	private ProjecaoFacadeImpl facade = new ProjecaoFacadeImpl();

	@Mock
	private DebitavelFacade mockDebitavelFacade;

	@Test
	public void test() throws Exception {

		Conta conta = new Conta();
		conta.setId(10L);
		conta.setSaldo(new BigDecimal("0"));

		Date dataInicial = DateUtils.addDays(new Date(), 1);
		Date dataFinal = DateUtils.addYears(dataInicial, 1);

		Periodo periodo = new Periodo(dataInicial, dataFinal);

		when(mockDebitavelFacade.getMediaVariacao(conta)).thenReturn(new BigDecimal("10"));

		Projecao projecao = facade.criarProjecao(conta, periodo);

		verify(mockDebitavelFacade).getMediaVariacao(conta);

		assertNotNull(projecao);
		assertEquals(13, projecao.getItens().size());

		assertEquals(new BigDecimal("10"), projecao.getItens().get(0).getValor());
		assertEquals(new BigDecimal("20"), projecao.getItens().get(1).getValor());
		assertEquals(new BigDecimal("30"), projecao.getItens().get(2).getValor());
		assertEquals(new BigDecimal("40"), projecao.getItens().get(3).getValor());
		assertEquals(new BigDecimal("50"), projecao.getItens().get(4).getValor());
		assertEquals(new BigDecimal("60"), projecao.getItens().get(5).getValor());
		assertEquals(new BigDecimal("70"), projecao.getItens().get(6).getValor());
		assertEquals(new BigDecimal("80"), projecao.getItens().get(7).getValor());
		assertEquals(new BigDecimal("90"), projecao.getItens().get(8).getValor());
		assertEquals(new BigDecimal("100"), projecao.getItens().get(9).getValor());
		assertEquals(new BigDecimal("110"), projecao.getItens().get(10).getValor());
		assertEquals(new BigDecimal("120"), projecao.getItens().get(11).getValor());
	}

}
