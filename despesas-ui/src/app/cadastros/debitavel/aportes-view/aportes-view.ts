import { Component, inject, OnInit, signal } from '@angular/core';
import { DividaService } from '../../../services/divida-service';
import { ActivatedRoute, Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { concatMap } from 'rxjs';
import { Divida } from '../../../models/debitavel.model';
import { Transferencia } from '../../../models/movimentacao.model';
import { Loader } from "../../../components/loader/loader";
import { TableModule } from "primeng/table";
import { ColorDisplay } from "../../../components/color-display/color-display";
import { DatePipe, DecimalPipe } from '@angular/common';
import { SumPipe } from '../../../pipes/sum-pipe';
import { ButtonModule } from "primeng/button";

@Component({
  selector: 'app-aportes-view',
  imports: [Loader, TableModule, ColorDisplay, DatePipe, DecimalPipe, SumPipe, ButtonModule],
  templateUrl: './aportes-view.html',
  styleUrl: './aportes-view.scss'
})
export class AportesView implements OnInit {

  loading = signal<boolean>(true);
  divida?: Divida;
  transferencias: Transferencia[] = [];

  private dividaService = inject(DividaService);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);
  private router = inject(Router);

  constructor() { }

  ngOnInit(): void {
    this.loadData();
  }

  private loadData() {

    var id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {

      this.dividaService.fetchById(parseInt(id)).pipe(
        concatMap((divida: Divida) => {
          this.divida = divida;
          return this.dividaService.fetchPagamentos(divida.id);
        })
      ).subscribe((transferencias: Transferencia[]) => {
        this.transferencias = transferencias;
        this.loading.set(false);
      });

    } else {
      this.messageService.add({ severity: 'error', summary: 'Erro', detail: 'Dívida não encontrada!', life: 3000 });
      this.router.navigate(['dividas']);
    }
  }

  returnToView() {
    this.router.navigate(['dividas']);
  }

}