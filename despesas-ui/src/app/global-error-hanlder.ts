import { ErrorHandler, Injectable } from "@angular/core";
import { MessageService } from "primeng/api";

@Injectable({
    providedIn: 'root'
})
export class GlobalErrorHandler extends ErrorHandler {

    constructor(private messageService: MessageService) {
        super();
    }

    override handleError(error: any): void {
        console.info(error);
    }

}