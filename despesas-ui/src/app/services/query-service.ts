import { Injectable } from '@angular/core';
import { QueryUtil } from '../models/query.util';

@Injectable({
  providedIn: 'root',
})
export class QueryService {


  process(queryText: string): string {

    return queryText.replace(/\$\{([^}]+)\}/g, (_, expression) => {

      expression = expression.trim();

      const matchFuncao = expression.match(/^([a-zA-Z]+)/);
      if (!matchFuncao) {
        throw new Error(`Expressão inválida: ${expression}`);
      }

      const nomeFuncao = matchFuncao[1];
      const funcao = QueryUtil.FUNCOES.get(nomeFuncao);

      if (!funcao) {
        throw new Error(`Função não reconhecida: ${nomeFuncao}!`);
      }

      return funcao(expression);

    });
  }

}
