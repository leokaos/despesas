import { Component, Inject, input, output } from '@angular/core';
import { RouterModule } from '@angular/router';
import { APP_CONFIG, AppConfig } from '../../app-config';
import { Notificacao } from '../../models/notificacao.model';
import { ButtonModule, ButtonSeverity } from 'primeng/button';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-header',
  imports: [RouterModule, ButtonModule],
  templateUrl: './header.html',
  styleUrl: './header.scss'
})
export class Header {

  notificacoes = input.required<Notificacao[]>();

  onOpenNotificacao = output<boolean>();

  version: string;

  constructor(@Inject(APP_CONFIG) config: AppConfig) {
    this.version = config.version;
  }

}
