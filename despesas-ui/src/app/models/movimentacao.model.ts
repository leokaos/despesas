import { Debitavel, Moeda } from './debitavel.model';
import { TipoMovimentacao } from './tipo-movimentacao.model';
export interface Movimentacao {
  id: number | null;
  descricao: string;
  valor: number;
  vencimento: Date;
  pagamento: Date;
  debitavel: Debitavel;
  moeda: Moeda;
  tipo: TipoMovimentacao;
}

export interface Despesa extends Movimentacao {
  paga: boolean;
}

export interface Receita extends Movimentacao {
  depositado: boolean;
}

export interface Transferencia extends Movimentacao {
  creditavel: Debitavel;
  valorReal: number;
}
