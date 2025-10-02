// models/mes.model.ts
export class Mes {
  constructor(public id: number, public name: string) {}

  static readonly JANEIRO = new Mes(0, 'Janeiro');
  static readonly FEVEREIRO = new Mes(1, 'Fevereiro');
  static readonly MARCO = new Mes(2, 'Março');
  static readonly ABRIL = new Mes(3, 'Abril');
  static readonly MAIO = new Mes(4, 'Maio');
  static readonly JUNHO = new Mes(5, 'Junho');
  static readonly JULHO = new Mes(6, 'Julho');
  static readonly AGOSTO = new Mes(7, 'Agosto');
  static readonly SETEMBRO = new Mes(8, 'Setembro');
  static readonly OUTUBRO = new Mes(9, 'Outubro');
  static readonly NOVEMBRO = new Mes(10, 'Novembro');
  static readonly DEZEMBRO = new Mes(11, 'Dezembro');

  static values(): Mes[] {
    return [
      this.JANEIRO,
      this.FEVEREIRO,
      this.MARCO,
      this.ABRIL,
      this.MAIO,
      this.JUNHO,
      this.JULHO,
      this.AGOSTO,
      this.SETEMBRO,
      this.OUTUBRO,
      this.NOVEMBRO,
      this.DEZEMBRO,
    ];
  }

  static getPorId(id: number): Mes | undefined {
    return this.values().find((mes) => mes.id === id);
  }

  static getMesAtual(): Mes {
    var mesAtual = new Date().getMonth();
    var mes = this.getPorId(mesAtual) || this.JANEIRO;

    //Cloning para evitar erros de detecção
    return new Mes(mes.id, mes.name);
  }
}
