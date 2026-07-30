import { Alerta } from "./alerta.model";

export interface Notificacao {
    id: number;
    executado: boolean;
    alerta: Alerta;
    targetDate: string;
    mes: null | string;
}