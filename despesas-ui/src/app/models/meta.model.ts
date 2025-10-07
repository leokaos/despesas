export interface Meta {
  id: number;
  valorDiario: number;
  valor: number;
  descricao: string;
  saldo: number;
  mes: {
    mes: number;
    ano: number;
  };
}
