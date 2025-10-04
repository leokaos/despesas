import { Debitavel, Moeda } from './debitavel.model';
import { TipoDespesa } from './tipo-movimentacao.model';
export interface Movimentacao {
  id: number;
  descricao: string;
  valor: number;
  vencimento: Date;
  pagamento: Date;
  debitavel: Debitavel;
  moeda: Moeda;
}

export interface Despesa extends Movimentacao {
  tipo: TipoDespesa;
}

export interface Receita extends Movimentacao { }

export interface Transferencia extends Movimentacao {
  creditavel: Debitavel;
  valorReal: number;
}
