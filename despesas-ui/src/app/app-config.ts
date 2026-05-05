import { InjectionToken } from "@angular/core";

export interface AppConfig {
    apiUrl: string,
    wsUrl: string,
    version: string,
}

export let APP_CONFIG = new InjectionToken<AppConfig>('app.config');