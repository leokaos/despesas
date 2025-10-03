import { Debitavel, Moeda } from './debitavel.model';
export interface Movimentacao {
  id: number;
  descricao: string;
  valor: number;
  vencimento: Date;
  pagamento: Date;
  debitavel: Debitavel;
  moeda: Moeda;
}

export interface Despesa extends Movimentacao {}

export interface Receita extends Movimentacao {}

export interface Transferencia extends Movimentacao {
  creditavel: Debitavel;
  valorReal: number;
}
