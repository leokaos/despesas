package org.leo.despesas.test;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import org.apache.commons.lang3.time.DateUtils;
import org.junit.Test;
import org.leo.despesas.dominio.GraficoVO;

public class EntityManagerSandBox {

	@SuppressWarnings("unchecked")
//	@Test
	public void testName() throws Exception {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("testePU");
		EntityManager em = emf.createEntityManager();

		StringBuilder builder = new StringBuilder();
		builder.append("SELECT NEW org.leo.despesas.dominio.GraficoVO(d.tipoDespesa.descricao, SUM(d.valor)) FROM Despesa d ");
		// builder.append("SELECT d.tipoDespesa.descricao, SUM(d.valor) FROM Despesa d ");
		builder.append("WHERE d.pagamento between :dataInicial AND :dataFinal ");
		builder.append("GROUP BY d.tipoDespesa.descricao");

		Query query = em.createQuery(builder.toString());

		query.setParameter("dataInicial", DateUtils.addMonths(new Date(), -1));
		query.setParameter("dataFinal", new Date());

		List<GraficoVO> lis = query.getResultList();

		for (GraficoVO graficoVO : lis) {
			System.out.println(graficoVO);
		}
	}

	@Test
	public void testName1() throws Exception {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
		System.out.println(format.format(new Date()));
	}
}
