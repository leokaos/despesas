
export interface Movimentacao {

    id: number,
    descricao: string,
    valor: number,
    vencimento: Date,
    pagamento: Date
}

export interface Despesa extends Movimentacao {

}

export interface Receita extends Movimentacao {

}