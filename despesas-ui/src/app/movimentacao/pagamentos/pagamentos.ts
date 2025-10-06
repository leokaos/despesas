import { CommonModule } from '@angular/common';
import { Component, inject, OnInit } from '@angular/core';
import { FullCalendarModule } from '@fullcalendar/angular';
import { CalendarOptions } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import { MovimentacaoFiltro, MovimentacaoService } from '../../services/movimentacao-service';
import { Movimentacao } from '../../models/movimentacao.model';

@Component({
  selector: 'app-pagamentos',
  imports: [CommonModule, FullCalendarModule],
  templateUrl: './pagamentos.html',
  styleUrl: './pagamentos.scss'
})
export class Pagamentos implements OnInit {

  calendarOptions?: CalendarOptions;

  private movimentacaoService = inject(MovimentacaoService);

  constructor() { }

  ngOnInit(): void {

    this.calendarOptions = {
      initialView: 'dayGridMonth',
      plugins: [dayGridPlugin],
      locales: [{ code: 'pt-br' }],
      buttonText: { today: "Hoje" },
      events: this.loadEvents.bind(this),
    };

  }

  private loadEvents(info: any, successCallback: any, failureCallback: any) {

    let filtro = {
      dataInicial: info.start,
      dataFinal: info.end
    } as MovimentacaoFiltro;

    this.movimentacaoService.fetch(filtro).subscribe((data: Movimentacao[]) => {

      let events = data.map((movimentacao: Movimentacao) => (
        {
          title: movimentacao.descricao,
          date: movimentacao.vencimento,
          cor: movimentacao.tipo.cor
        }));

      successCallback(events);

    });
  }

}