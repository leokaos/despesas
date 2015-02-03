package org.leo.despesas.dominio.despesa;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.leo.despesas.dominio.Despesa;
import org.leo.despesas.dominio.GraficoVO;
import org.leo.despesas.dominio.Periodo;

@Stateless
public class DespesaFacadeImpl implements DespesaFacade {

	@PersistenceContext(unitName = "despesasPU")
	private EntityManager entityManager;

	@Override
	@SuppressWarnings("unchecked")
	public List<Despesa> listar() {
		return entityManager.createQuery("SELECT despesa FROM Despesa despesa")
				.getResultList();
	}

	@Override
	public Despesa buscarPorId(Object id) {
		return entityManager.find(Despesa.class, (Long) id);
	}

	@Override
	public void inserir(Despesa t) {
		entityManager.persist(t);
	}

	@Override
	public void salvar(Despesa t) {
		entityManager.merge(t);
	}

	@Override
	public void deletar(Long id) {
		entityManager.remove(buscarPorId(id));
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<GraficoVO> getGraficoPorPeriodo(Periodo periodo) {
		StringBuilder builder = new StringBuilder();

		builder.append("SELECT NEW org.leo.despesas.dominio.GraficoVO(d.tipoDespesa.descricao,d.tipoDespesa.cor, SUM(d.valor)) FROM Despesa d ");
		builder.append("WHERE d.vencimento BETWEEN :dataInicial AND :dataFinal ");
		builder.append("GROUP BY d.tipoDespesa.descricao, d.tipoDespesa.cor");

		Query query = entityManager.createQuery(builder.toString());

		query.setParameter("dataInicial", periodo.getDataInicial());
		query.setParameter("dataFinal", periodo.getDataFinal());

		return query.getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Despesa> getDespesasPorPeriodo(Periodo periodo) {

		StringBuilder builder = new StringBuilder();

		builder.append("SELECT d FROM Despesa d WHERE d.vencimento BETWEEN :dataInicial AND :dataFinal ");

		Query query = entityManager.createQuery(builder.toString());

		query.setParameter("dataInicial", periodo.getDataInicial());
		query.setParameter("dataFinal", periodo.getDataFinal());

		return query.getResultList();
	}
}