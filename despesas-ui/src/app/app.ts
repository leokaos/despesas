import { Component, inject, OnInit, signal } from '@angular/core';
import { RouterModule, RouterOutlet } from '@angular/router';
import { ButtonModule, ButtonSeverity } from 'primeng/button';
import { Header } from './header/header/header';
import { ToastModule } from 'primeng/toast';
import { MessageService } from 'primeng/api';
import { NotificacaoService } from './services/notificacao-service';
import { Notificacao } from './models/notificacao.model';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, ButtonModule, Header, ToastModule, RouterModule],
  templateUrl: './app.html',
  styleUrl: './app.scss',
  standalone: true
})
export class App implements OnInit {

  notificacoes = signal<Notificacao[]>([]);

  private notificacaoService = inject(NotificacaoService);

  constructor() { }

  ngOnInit(): void {
    this.notificacaoService.fetch().subscribe(data => {
      this.notificacoes.set(data);
    });
  }

}
