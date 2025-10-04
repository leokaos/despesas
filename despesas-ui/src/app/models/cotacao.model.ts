import { Moeda } from "./debitavel.model";

export interface Cotacao {
    id: number;
    data: Date;
    origem: Moeda;
    destino: Moeda;
    taxa: number;
}
