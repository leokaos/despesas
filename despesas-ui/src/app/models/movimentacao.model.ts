import { Debitavel, Moeda } from './debitavel.model';
import { Notificacao } from './notificacao.model';
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
  notificacao?: Notificacao;
}

export interface Receita extends Movimentacao {
  depositado: boolean;
  compromissada: boolean;
}

export interface Transferencia extends Movimentacao {
  creditavel: Debitavel;
  valorReal: number;
}

export interface ParcelamentoVO {
  parcelas: number;
  tipo: 'Semanal' | 'Mensal' | 'Semestral' | 'Anual';
}
