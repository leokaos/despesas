import {
  ApplicationConfig,
  provideBrowserGlobalErrorListeners,
  provideZonelessChangeDetection,
} from '@angular/core';
import { provideRouter, withComponentInputBinding } from '@angular/router';

import { routes } from './app.routes';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import { providePrimeNG } from 'primeng/config';
import Aura from '@primeuix/themes/aura';
import { HTTP_INTERCEPTORS, provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import '@angular/common/locales/global/pt';
import { pt } from 'primelocale/pt.json';
import { DateInterceptor } from './interceptors/date.interceptor';

export const appConfig: ApplicationConfig = {
  providers: [
    provideAnimationsAsync(),
    providePrimeNG({
      translation: pt,
      theme: {
        preset: Aura,
      },
    }),
    provideBrowserGlobalErrorListeners(),
    provideZonelessChangeDetection(),
    provideHttpClient(withInterceptorsFromDi()),
    provideRouter(routes, withComponentInputBinding()),
    { provide: HTTP_INTERCEPTORS, useClass: DateInterceptor, multi: true },
  ],
};
