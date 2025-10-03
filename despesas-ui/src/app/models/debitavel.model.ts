import { InvestimentoView } from './../cadastros/debitavel/investimento-view/investimento-view';
export class Moeda {
  static readonly REAL = new Moeda('REAL', 'R$', 'Real');
  static readonly EURO = new Moeda('EURO', '€', 'Euro');

  private displayValue: string;

  private constructor(
    public readonly codigo: string,
    public readonly simbolo: string,
    public readonly nome: string
  ) {
    this.displayValue = `${nome} (${simbolo})`;
  }

  static fromCodigo(codigo: string): Moeda {
    const moedas = [Moeda.REAL, Moeda.EURO];
    return moedas.find((m) => m.codigo === codigo) || Moeda.REAL;
  }

  static values() {
    return [this.REAL, this.EURO];
  }
}

export interface Debitavel {
  id: number;
  descricao: string;
  cor: string;
  ativo: boolean;
  moeda: Moeda;
  tipo: string;
}

export interface Conta extends Debitavel {
  saldo: number;
}

export interface Divida extends Debitavel {
  periodicidade: 'MENSAL' | 'SEMESTRAL' | 'VARIAVEL';
  valorTotal: number;
  dataInicio: Date;
}

export interface Investimento extends Debitavel {
  valorReceitas: number;
  yield: number;
  montante: number;
  rendimento: number;
  periodicidade: 'MENSAL' | 'SEMESTRAL' | 'VARIAVEL';
}

export enum Bandeira {
  VISA = 'VISA',
  MASTERCARD = 'MASTERCARD',
  AMERICAN_EXPRESS = 'AMERICAN_EXPRESS',
}

export interface CartaoCredito extends Debitavel {
  bandeira: Bandeira;
  limite: number;
  diaDeFechamento: number;
  diaDeVencimento: number;
}
