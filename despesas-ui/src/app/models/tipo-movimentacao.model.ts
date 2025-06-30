
export interface TipoMovimentacao {

    id: number,
    descricao: string,
    cor: string
}

export interface TipoDespesa extends TipoMovimentacao {

}

export interface TipoReceita extends TipoMovimentacao {

}