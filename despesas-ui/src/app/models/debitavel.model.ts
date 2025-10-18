import {
  faCcVisa,
  faCcMastercard,
  faCcAmex,
  IconDefinition,
} from '@fortawesome/free-brands-svg-icons';
import { Despesa } from './movimentacao.model';

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

export class Bandeira {
  static readonly VISA = new Bandeira('VISA', 'Visa', faCcVisa);
  static readonly MASTERCARD = new Bandeira('MASTERCARD', 'MasterCard', faCcMastercard);
  static readonly AMERICAN_EXPRESS = new Bandeira('AMERICAN_EXPRESS', 'American Express', faCcAmex);

  private constructor(
    public readonly codigo: string,
    public readonly nome: string,
    public readonly icon: IconDefinition
  ) {}

  static fromCodigo(codigo: string): Bandeira {
    const moedas = [Bandeira.VISA, Bandeira.MASTERCARD, Bandeira.AMERICAN_EXPRESS];
    return moedas.find((m) => m.codigo === codigo) || Bandeira.VISA;
  }

  static values() {
    return [Bandeira.VISA, Bandeira.MASTERCARD, Bandeira.AMERICAN_EXPRESS];
  }
}

export interface Debitavel {
  id: number;
  descricao: string;
  cor: string;
  ativo: boolean;
  moeda: Moeda;
  tipo: string;
  saldo: number;
}

export interface Conta extends Debitavel {
  saldo: number;
}

export interface Divida extends Debitavel {
  periodicidade: 'MENSAL' | 'SEMESTRAL' | 'VARIAVEL';
  valorTotal: number;
  dataInicio: Date;
  valorRestante: number;
}

export interface Investimento extends Debitavel {
  valorReceitas: number;
  yield: number;
  montante: number;
  rendimento: number;
  periodicidade: 'MENSAL' | 'SEMESTRAL' | 'VARIAVEL';
}

export interface CartaoCredito extends Debitavel {
  bandeira: Bandeira;
  limite: number;
  diaDeFechamento: number;
  diaDeVencimento: number;
}

export interface Fatura {
  id: number;
  cartao: CartaoCredito;
  dataVencimento: Date;
  dataFechamento: Date;
  paga: boolean;
  despesas: Despesa[];
  valorFatura: number;
}
