export interface Meta {
  id: number;
  valorDiario: number;
  valor: number;
  descricao: string;
  mes: {
    mes: number;
    ano: number;
  };
}
