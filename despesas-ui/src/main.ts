import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { AppModule } from './app/app.module';
import { APP_CONFIG } from './app/app-config';

fetch("app-config.json")
  .then(response => response.json())
  .then(config => {

    platformBrowserDynamic([
      { provide: APP_CONFIG, useValue: config }
    ])
      .bootstrapModule(AppModule, {
        ngZoneEventCoalescing: true
      }).catch(err => console.error(err));

  });
