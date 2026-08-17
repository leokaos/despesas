import { Alerta } from "./alerta.model";

export interface Notificacao {
    id: number;
    executado: boolean;
    alerta: Alerta;
    targetDate: Date;
    mes: null | string;
}