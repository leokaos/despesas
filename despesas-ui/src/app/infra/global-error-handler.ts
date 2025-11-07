import { ErrorHandler, inject, Injectable } from "@angular/core";
import { MessageService } from "primeng/api";

@Injectable({
    providedIn: 'root',
})
export class GlobalErrorHandler implements ErrorHandler {

    private messageService = inject(MessageService);

    handleError(error: any) {
        this.messageService.add({ severity: 'error', summary: 'Error', detail: error.error || error, life: 3000 });
    }
}