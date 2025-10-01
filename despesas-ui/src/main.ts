/// <reference types="@angular/localize" />

import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { App } from './app/app';
import { APP_CONFIG } from './app/app-config';

const configUrl = 'app-config.json';

fetch(configUrl)
  .then((response) => response.json())
  .then((config) => {

    appConfig.providers.push({ provide: APP_CONFIG, useValue: config })

    bootstrapApplication(App, appConfig)
      .catch((err) => console.error(err));
  });


