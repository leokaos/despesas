import { Component, Inject, input } from '@angular/core';
import { RouterModule } from '@angular/router';
import { APP_CONFIG, AppConfig } from '../../app-config';
import { Notificacao } from '../../models/notificacao.model';
import { ButtonModule, ButtonSeverity } from 'primeng/button';

@Component({
  selector: 'app-header',
  imports: [RouterModule, ButtonModule],
  templateUrl: './header.html',
  styleUrl: './header.scss'
})
export class Header {

  notificacoes = input.required<Notificacao[]>();

  version: string;

  constructor(@Inject(APP_CONFIG) config: AppConfig) {
    this.version = config.version;
  }

}
