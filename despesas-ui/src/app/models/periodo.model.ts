import { Mes } from './mes.model';

export interface Periodo {
  mes: Mes;
  ano: number;
}

export class PeriodoUtil {
  static getDataInicial(periodo: Periodo): Date {
    return new Date(Date.UTC(periodo.ano, periodo.mes.id, 1, 0, 0, 0, 0));
  }

  static getDataFinal(periodo: Periodo): Date {
    return new Date(Date.UTC(periodo.ano, periodo.mes.id + 1, 0, 23, 59, 59, 999));
  }
}
