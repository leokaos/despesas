import { CartaoCredito, Divida } from "./debitavel.model";

export enum TipoAlerta {
    FATURA_CARTAO_CREDITO = 'FATURA_CARTAO_CREDITO',
    DESPESA_RECORRENTE = 'DESPESA_RECORRENTE',
    VALOR_LIMITE_DIVIDA = 'VALOR_LIMITE_DIVIDA'
}

export interface Alerta {
    id: number;
    tipo: TipoAlerta;
    descricao: string;
    diasAntesDeAviso: number;
    detalhe: string;
    tipoLabel: string;
    cartao?: CartaoCredito;
    divida?: Divida;
    titulo?: string;
    tipoPeriodicidade?: string;
    diaAlvo?: number;
}

