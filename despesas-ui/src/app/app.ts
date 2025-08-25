import { Component } from '@angular/core';
import { RouterModule, RouterOutlet } from '@angular/router';
import { ButtonModule } from 'primeng/button';
import { Header } from './header/header/header';
import { ToastModule } from 'primeng/toast';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, ButtonModule, Header, ToastModule, RouterModule],
  providers: [MessageService],
  templateUrl: './app.html',
  styleUrl: './app.scss',
  standalone: true
})
export class App {

  constructor(private messageService: MessageService) {

  }

}
