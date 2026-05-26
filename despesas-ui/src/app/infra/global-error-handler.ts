import { ErrorHandler, inject, Injectable } from "@angular/core";
import { MessageService } from "primeng/api";

@Injectable({
    providedIn: 'root',
})
export class GlobalErrorHandler implements ErrorHandler {

    private messageService = inject(MessageService);

    handleError(error: any) {

        const mensagem = (error.error && typeof error.error === 'object')
            ? (error.statusText || 'Erro desconhecido')
            : (error.error || error.statusText || error || 'Erro desconhecido');

        this.messageService.add({ severity: 'error', summary: 'Error', detail: mensagem, life: 3000 });
    }
}