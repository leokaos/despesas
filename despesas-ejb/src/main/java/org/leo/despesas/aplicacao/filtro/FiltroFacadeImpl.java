package org.leo.despesas.aplicacao.filtro;

import java.util.List;

import javax.ejb.Stateless;

import org.leo.despesas.dominio.filtro.Filtro;
import org.leo.despesas.dominio.filtro.FiltroModelFiltro;
import org.leo.despesas.infra.AbstractFacade;
import org.leo.despesas.infra.exception.AlreadyExistentEntityException;
import org.leo.despesas.infra.exception.DespesasException;
import org.leo.despesas.infra.exception.ValidationEntityException;

import cz.jirutka.rsql.parser.RSQLParser;
import cz.jirutka.rsql.parser.RSQLParserException;

@Stateless
public class FiltroFacadeImpl extends AbstractFacade<Filtro, FiltroModelFiltro> implements FiltroFacade {

	@Override
	protected Class<Filtro> getClasseEntidade() {
		return Filtro.class;
	}

	@Override
	protected String getTopicName() {
		return "filtros";
	}

	private void validateExpressao(String expressao) throws ValidationEntityException {
		try {
			new RSQLParser().parse(expressao);
		} catch (RSQLParserException e) {
			throw new ValidationEntityException("Expressao incorreta!");
		}
	}

	private void validateExistentFiltro(String nome, String classe) throws DespesasException {

		FiltroModelFiltro filtro = new FiltroModelFiltro();
		filtro.setClasse(classe);
		filtro.setNome(nome);

		List<Filtro> filtros = this.listar(filtro);

		if (!filtros.isEmpty()) {
			throw new AlreadyExistentEntityException("Filtro já existe para esse nome e tipo");
		}
	}

	@Override
	protected void preInserir(Filtro t) throws DespesasException {

		validateExpressao(t.getExpressao());
		validateExistentFiltro(t.getNome(), t.getClasse());

	}

	@Override
	protected void preSalvar(Filtro antigo, Filtro novo) throws DespesasException {

		validateExpressao(novo.getExpressao());

		if (antigo.getNome() != novo.getNome()) {
			validateExistentFiltro(novo.getNome(), novo.getClasse());
		}

		if (antigo.getClasse() != novo.getClasse()) {
			throw new ValidationEntityException("Não é permitido trocar de tipo de filtro!");
		}
	}

}