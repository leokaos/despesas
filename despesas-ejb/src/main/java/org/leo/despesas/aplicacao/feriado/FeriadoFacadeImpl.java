package org.leo.despesas.aplicacao.feriado;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.ejb.Stateless;
import javax.inject.Inject;

import org.leo.despesas.dominio.feriado.Feriado;
import org.leo.despesas.dominio.feriado.FeriadoFiltro;
import org.leo.despesas.dominio.feriado.FeriadoTipo;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.infra.exception.ValidationEntityException;
import org.leo.despesas.infra.feriado.FeriadoDTO;
import org.leo.despesas.infra.feriado.FeriadoRepositorio;

import com.google.common.collect.Lists;

@Stateless
public class FeriadoFacadeImpl extends AbstractFacade<Feriado, FeriadoFiltro> implements FeriadoFacade {

	private static final SimpleDateFormat FORMATTER = new SimpleDateFormat("yyyy-MM-dd");

	@Inject
	private FeriadoRepositorio feriadoRepositorio;

	@Override
	public List<Feriado> getFeriadosPelaApi(Integer ano, FeriadoTipo tipo) throws DespesasException {

		try {
			List<FeriadoDTO> feriadosExternos = feriadoRepositorio.getFeriadosPelaApi(ano);

			List<Feriado> feriados = Lists.newArrayList();

			for (FeriadoDTO feriadoDTO : feriadosExternos) {

				Date data = FORMATTER.parse(feriadoDTO.getDate());

				if (data.after(new Date()) && feriadoDTO.getCounties() == null) {

					Feriado feriado = new Feriado();
					feriado.setTipo(tipo);
					feriado.setData(new java.sql.Date(data.getTime()));
					feriado.setNome(feriadoDTO.getLocalName());

					feriados.add(feriado);
				}

			}

			return feriados;

		} catch (ParseException e) {
			throw new ValidationEntityException("Erro ao parsear feriados!");
		}
	}

	@Override
	protected Class<Feriado> getClasseEntidade() {
		return Feriado.class;
	}

}
