package org.leo.despesas.aplicacao.projecao;

import static org.easymock.EasyMock.expect;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.verify;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang3.time.DateUtils;
import org.easymock.EasyMockRunner;
import org.easymock.Mock;
import org.easymock.MockType;
import org.easymock.TestSubject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.leo.despesas.aplicacao.debitavel.DebitavelFacade;
import org.leo.despesas.dominio.debitavel.Conta;
import org.leo.despesas.dominio.projecao.Projecao;
import org.leo.despesas.infra.Periodo;

@RunWith(EasyMockRunner.class)
public class ProjecaoFacadeImplTest {

	private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");

	@TestSubject
	private ProjecaoFacadeImpl facade = new ProjecaoFacadeImpl();

	@Mock(type = MockType.STRICT)
	private DebitavelFacade mockDebitavelFacade;

	@Test
	public void test() throws Exception {

		Conta conta = new Conta();
		conta.setId(10L);
		conta.setSaldo(new BigDecimal("0"));

		Date dataInicial = DATE_FORMAT.parse("01/05/2019");
		Date dataFinal = DATE_FORMAT.parse("30/04/2020");

		Periodo periodo = new Periodo(dataInicial, dataFinal);

		expect(mockDebitavelFacade.getMediaVariacao(conta)).andReturn(new BigDecimal("10"));

		replay(mockDebitavelFacade);

		Projecao projecao = facade.criarProjecao(conta, periodo);

		verify(mockDebitavelFacade);

		assertNotNull(projecao);
		assertEquals(12, projecao.getItens().size());

		assertTrue(DateUtils.truncatedCompareTo(DATE_FORMAT.parse("01/05/2019"), projecao.getItens().get(0).getData(), Calendar.DAY_OF_MONTH) == 0);
		assertEquals(new BigDecimal("10"), projecao.getItens().get(0).getValor());

		assertTrue(DateUtils.truncatedCompareTo(DATE_FORMAT.parse("01/06/2019"), projecao.getItens().get(1).getData(), Calendar.DAY_OF_MONTH) == 0);
		assertEquals(new BigDecimal("20"), projecao.getItens().get(1).getValor());

		assertTrue(DateUtils.truncatedCompareTo(DATE_FORMAT.parse("01/07/2019"), projecao.getItens().get(2).getData(), Calendar.DAY_OF_MONTH) == 0);
		assertEquals(new BigDecimal("30"), projecao.getItens().get(2).getValor());

		assertTrue(DateUtils.truncatedCompareTo(DATE_FORMAT.parse("01/08/2019"), projecao.getItens().get(3).getData(), Calendar.DAY_OF_MONTH) == 0);
		assertEquals(new BigDecimal("40"), projecao.getItens().get(3).getValor());

		assertTrue(DateUtils.truncatedCompareTo(DATE_FORMAT.parse("01/09/2019"), projecao.getItens().get(4).getData(), Calendar.DAY_OF_MONTH) == 0);
		assertEquals(new BigDecimal("50"), projecao.getItens().get(4).getValor());

		assertTrue(DateUtils.truncatedCompareTo(DATE_FORMAT.parse("01/10/2019"), projecao.getItens().get(5).getData(), Calendar.DAY_OF_MONTH) == 0);
		assertEquals(new BigDecimal("60"), projecao.getItens().get(5).getValor());

		assertTrue(DateUtils.truncatedCompareTo(DATE_FORMAT.parse("01/11/2019"), projecao.getItens().get(6).getData(), Calendar.DAY_OF_MONTH) == 0);
		assertEquals(new BigDecimal("70"), projecao.getItens().get(6).getValor());

		assertTrue(DateUtils.truncatedCompareTo(DATE_FORMAT.parse("01/12/2019"), projecao.getItens().get(7).getData(), Calendar.DAY_OF_MONTH) == 0);
		assertEquals(new BigDecimal("80"), projecao.getItens().get(7).getValor());

		assertTrue(DateUtils.truncatedCompareTo(DATE_FORMAT.parse("01/01/2020"), projecao.getItens().get(8).getData(), Calendar.DAY_OF_MONTH) == 0);
		assertEquals(new BigDecimal("90"), projecao.getItens().get(8).getValor());

		assertTrue(DateUtils.truncatedCompareTo(DATE_FORMAT.parse("01/02/2020"), projecao.getItens().get(9).getData(), Calendar.DAY_OF_MONTH) == 0);
		assertEquals(new BigDecimal("100"), projecao.getItens().get(9).getValor());

		assertTrue(DateUtils.truncatedCompareTo(DATE_FORMAT.parse("01/03/2020"), projecao.getItens().get(10).getData(), Calendar.DAY_OF_MONTH) == 0);
		assertEquals(new BigDecimal("110"), projecao.getItens().get(10).getValor());

		assertTrue(DateUtils.truncatedCompareTo(DATE_FORMAT.parse("01/04/2020"), projecao.getItens().get(11).getData(), Calendar.DAY_OF_MONTH) == 0);
		assertEquals(new BigDecimal("120"), projecao.getItens().get(11).getValor());
	}

}
