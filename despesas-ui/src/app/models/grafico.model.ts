export interface GraficoLinha {
    series: Serie[];
    nome: string;
}

export interface Serie {
    cor: string;
    pontos: Ponto[];
    nome: string;
}

export interface Ponto {
    y: number;
    x: number;
}