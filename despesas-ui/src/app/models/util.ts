import { Periodo } from './periodo.model';

export class PeriodoUtil {
  static getDataInicial(periodo: Periodo): Date {
    return new Date(periodo.ano, periodo.mes.id, 1, 0, 0, 0, 0);
  }

  static getDataFinal(periodo: Periodo): Date {
    return new Date(periodo.ano, periodo.mes.id + 1, 0, 23, 59, 59, 999);
  }

  static getDataInicialUTC(periodo: Periodo): Date {
    return new Date(Date.UTC(periodo.ano, periodo.mes.id, 1, 0, 0, 0, 0));
  }

  static getDataFinalUTC(periodo: Periodo): Date {
    return new Date(Date.UTC(periodo.ano, periodo.mes.id + 1, 0, 23, 59, 59, 999));
  }
}

export class DateUtil {
  static getCurrentDataInicial() {
    let now = new Date();
    return new Date(now.getFullYear(), now.getMonth(), 1, 0, 0, 0, 0);
  }

  static getCurrentDataFinal() {
    let now = new Date();
    return new Date(now.getFullYear(), now.getMonth() + 1, 0, 23, 59, 59, 999);
  }

  static getUTCDate(date: Date): Date {
    return new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), date.getMinutes(), date.getSeconds()));
  }
}
