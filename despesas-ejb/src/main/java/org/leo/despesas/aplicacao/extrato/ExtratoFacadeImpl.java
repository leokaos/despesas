package org.leo.despesas.aplicacao.extrato;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TemporalType;

import org.leo.despesas.dominio.debitavel.Debitavel;
import org.leo.despesas.dominio.extrato.Extrato;

import com.google.common.collect.Lists;

@Stateless
public class ExtratoFacadeImpl implements ExtratoFacade {

	@PersistenceContext(unitName = "despesasPU")
	protected EntityManager entityManager;

	@Override
	@SuppressWarnings("unchecked")
	public List<Extrato> buscarPorPeriodo(Date dataInicio, Date dataFinal, Debitavel debitavel) {

		StringBuilder builder = new StringBuilder();

		builder.append("select extract(MONTH from DATA.vencimento) as mes, extract(YEAR from DATA.vencimento) as ano, ");
		builder.append("sum(DATA.entradas) as entradas, sum(DATA.saidas) as saidas, ");
		builder.append("sum(DATA.transferencia_entrada) as transferencia_entrada, sum(DATA.transferencia_saida) as transferencia_saida ");
		builder.append("from (");
		builder.append("select ");
		builder.append("CASE WHEN (select R.id from despesas_db.receita R where R.id = MO.id) is not null THEN 1 ELSE 0 END * MO.valor as entradas,");
		builder.append("CASE WHEN (select D.id from despesas_db.despesa D where D.id = MO.id) is not null THEN -1 ELSE 0 END * MO.valor as saidas,");
		builder.append("CASE WHEN (select TS.id from despesas_db.transferencia TS where TS.id = MO.id and MO.debitavel_id = ?) is not null THEN -1 ELSE 0 END * COALESCE(MO.valor,0) as transferencia_saida, ");
		builder.append("CASE WHEN (select TE.id from despesas_db.transferencia TE where TE.id = MO.id and TE.creditavel_id = ?) is not null THEN 1 ELSE 0 END * COALESCE(T.valor_real,0) as transferencia_entrada,");
		builder.append("MO.vencimento as vencimento ");
		builder.append("from despesas_db.movimentacao MO ");
		builder.append("left join despesas_db.transferencia T on T.id = MO.id ");
		builder.append("left join despesas_db.debitavel DD on DD.id = MO.debitavel_id ");
		builder.append("left join despesas_db.debitavel DC on DC.id = T.creditavel_id ");
		builder.append("where MO.vencimento between ? and ? and (MO.debitavel_id = ? or T.creditavel_id = ?)) as DATA ");
		builder.append("group by extract(MONTH from DATA.vencimento), extract(YEAR from DATA.vencimento)");

		final Query query = entityManager.createNativeQuery(builder.toString());

		query.setParameter(1, debitavel.getId());
		query.setParameter(2, debitavel.getId());

		query.setParameter(3, new Timestamp(dataInicio.getTime()), TemporalType.TIMESTAMP);
		query.setParameter(4, new Timestamp(dataFinal.getTime()), TemporalType.TIMESTAMP);

		query.setParameter(5, debitavel.getId());
		query.setParameter(6, debitavel.getId());

		List<Object[]> lista = query.getResultList();
		List<Extrato> extratos = Lists.newArrayList();

		for (Object[] data : lista) {
			extratos.add(new Extrato().mes(data[0]).ano(data[1]).entradas(data[2]).saidas(data[3]).transferenciaEntrada(data[4]).transferenciaSaida(data[5]));
		}

		return extratos;
	}

}
