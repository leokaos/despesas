import { Periodo } from './periodo.model';
import { TipoDespesa } from './tipo-movimentacao.model';

export interface Orcamento {
  id: number;
  valor: number;
  dataFinal: number;
  dataInicial: number;
  tipoDespesa: TipoDespesa;
  valorConsolidado: number;
  periodo: Periodo;
  descricao: string;
}
