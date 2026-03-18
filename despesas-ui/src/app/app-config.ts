import { InjectionToken } from "@angular/core";

export interface AppConfig {
    apiUrl: string,
    version: string,
}

export let APP_CONFIG = new InjectionToken<AppConfig>('app.config');