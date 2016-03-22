package org.leo.despesas.dominio;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.Assert;
import org.junit.Test;

public class DataBaseTest {

	@Test
	public void test() {

		EntityManagerFactory em = Persistence.createEntityManagerFactory("despesasTestPU");

		Assert.assertNotNull(em);
	}

}
