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

		Date dataInicial = DateUtils.addDays(new Date(), 1);
		Date dataFinal = DateUtils.addYears(dataInicial, 1);

		Periodo periodo = new Periodo(dataInicial, dataFinal);

		expect(mockDebitavelFacade.getMediaVariacao(conta)).andReturn(new BigDecimal("10"));

		replay(mockDebitavelFacade);

		Projecao projecao = facade.criarProjecao(conta, periodo);

		verify(mockDebitavelFacade);

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
