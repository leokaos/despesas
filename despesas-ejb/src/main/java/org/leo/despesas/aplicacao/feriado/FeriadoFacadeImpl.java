package org.leo.despesas.aplicacao.feriado;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.TypedQuery;

import org.leo.despesas.dominio.feriado.Feriado;
import org.leo.despesas.dominio.feriado.FeriadoFiltro;
import org.leo.despesas.dominio.feriado.FeriadoTipo;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.exception.AlreadyExistentEntityException;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.infra.exception.ValidationEntityException;
import org.leo.despesas.infra.feriado.FeriadoDTO;
import org.leo.despesas.infra.feriado.FeriadoRepositorio;

import com.google.common.collect.Lists;

@Stateless
public class FeriadoFacadeImpl extends AbstractFacade<Feriado, FeriadoFiltro> implements FeriadoFacade {

	private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

	@Inject
	private FeriadoRepositorio feriadoRepositorio;

	@Override
	public List<Feriado> getFeriadosPelaApi(Integer ano, FeriadoTipo tipo) throws DespesasException {

		try {
			List<FeriadoDTO> feriadosExternos = feriadoRepositorio.getFeriadosPelaApi(ano);

			List<Feriado> feriados = Lists.newArrayList();

			for (FeriadoDTO feriadoDTO : feriadosExternos) {

				LocalDate data = LocalDate.parse(feriadoDTO.getDate(), FORMATTER);

				if (data.isAfter(LocalDate.now()) && feriadoDTO.getCounties() == null) {

					Feriado feriado = new Feriado();
					feriado.setTipo(tipo);
					feriado.setData(data);
					feriado.setNome(feriadoDTO.getLocalName());

					feriados.add(feriado);
				}

			}

			return feriados;

		} catch (DateTimeParseException e) {
			throw new ValidationEntityException("Erro ao parsear feriados!");
		}
	}

	@Override
	protected void preInserir(Feriado t) throws DespesasException {

		TypedQuery<Feriado> query = entityManager.createQuery("SELECT F from Feriado F where F.data = :data", getClasseEntidade());
		query.setParameter("data", t.getData());

		if (!query.getResultList().isEmpty()) {
			throw new AlreadyExistentEntityException("Feriado já existe!");
		}

	}

	@Override
	protected Class<Feriado> getClasseEntidade() {
		return Feriado.class;
	}

	@Override
	protected String getTopicName() {
		return "feriado";
	}

}
