package org.leo.despesas.aplicacao.grafico;

import java.util.Date;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.leo.despesas.aplicacao.tipodespesa.TipoDespesaFacade;
import org.leo.despesas.infra.grafico.GraficoLinha;

@Stateless
public class GraficoFacadeImpl implements GraficoFacade {

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	@EJB
	private TipoDespesaFacade tipoDespesaFacade;

	@Override
	public GraficoLinha getGraficoDespesas(Date dataInicial,Date dataFinal) {
		return null;
	}

}
