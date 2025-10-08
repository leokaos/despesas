export interface GraficoItem {
    legenda: string;
    cor: string;
    valor: number;
}

export interface Grafico {
    titulo: string;
    tipoGrafico: 'BARRAS' | 'PIZZA' | 'LINHA';
    dados: GraficoItem[];
}