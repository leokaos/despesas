import { Component, inject, OnInit, signal } from '@angular/core';
import { RouterModule, RouterOutlet } from '@angular/router';
import { ButtonModule } from 'primeng/button';
import { Header } from './header/header/header';
import { ToastModule } from 'primeng/toast';
import { NotificacaoService } from './services/notificacao-service';
import { Notificacao } from './models/notificacao.model';
import { debounceTime, delay, merge, Subscription } from 'rxjs';
import { WebsocketService } from './services/websocket-service';
import { EntidadeEvent } from './models/evento.model';
import { DrawerModule } from 'primeng/drawer';
import { CommonModule, CurrencyPipe, DatePipe } from '@angular/common';
import { TipoAlerta } from './models/alerta.model';
import { BadgeModule } from 'primeng/badge';

@Component({
  selector: 'app-root',
  imports: [
    CommonModule,
    RouterOutlet,
    ButtonModule,
    Header,
    ToastModule,
    RouterModule,
    DrawerModule,
    DatePipe,
    BadgeModule
  ],
  templateUrl: './app.html',
  styleUrl: './app.scss',
  standalone: true
})
export class App implements OnInit {

  notificacoes = signal<Notificacao[]>([]);

  openNotifications: boolean = false;

  private notificacaoService = inject(NotificacaoService);
  private webSocketService = inject(WebsocketService);

  private notificacaoSubscription!: Subscription;

  tipoAlertaMap = {
    [TipoAlerta.FATURA_CARTAO_CREDITO]: 'Lembrete de fatura de cartão de crédito',
    [TipoAlerta.DESPESA_RECORRENTE]: 'Alerta de despesa recorrente',
    [TipoAlerta.VALOR_LIMITE_DIVIDA]: 'Data limite de dívida'
  };

  constructor() { }

  ngOnInit(): void {
    this.loadData();

    this.notificacaoSubscription = merge(
      this.webSocketService.getTopic<EntidadeEvent>("notificacao")
    ).pipe(
      debounceTime(300),
      delay(500)
    ).subscribe(_ => {
      this.loadData();
    });
  }

  loadData() {
    this.notificacaoService.fetch().subscribe(data => {
      this.notificacoes.set(data);
    });
  }

  calcularDiasRestantes(targetDate: string): number {
    const hoje = new Date();
    const target = new Date(targetDate);
    const diffTime = target.getTime() - hoje.getTime();
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    return diffDays;
  }

  executarNotificacao(_t18: Notificacao) {
    throw new Error('Method not implemented.');
  }

  ngOnDestroy() {
    if (this.notificacaoSubscription) {
      this.notificacaoSubscription.unsubscribe();
    }
  }

}
