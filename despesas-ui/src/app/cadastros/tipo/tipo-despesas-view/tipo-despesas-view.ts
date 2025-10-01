import { MessageService } from 'primeng/api';
import { TipoDespesaService } from './../../../services/tipo-despesa-service';
import { Component, inject, OnInit, signal } from '@angular/core';
import { TipoDespesa, TipoMovimentacao } from '../../../models/tipo-movimentacao.model';
import { TipoView } from '../tipo-view/tipo-view';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Loader } from '../../../components/loader/loader';

@Component({
  selector: 'app-tipo-despesas-view',
  imports: [TipoView, CommonModule, Loader],
  templateUrl: './tipo-despesas-view.html',
  styleUrl: './tipo-despesas-view.scss',
  standalone: true,
})
export class TipoDespesasView implements OnInit {
  data: TipoDespesa[] = [];
  loading = signal<boolean>(true);

  private tipoDespesaService = inject(TipoDespesaService);
  private messageService = inject(MessageService);
  private router = inject(Router);

  constructor() {}

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {
    this.tipoDespesaService.fetch().subscribe((data: TipoDespesa[]) => {
      this.data = [...data];
      this.loading.set(false);
    });
  }

  removerTipoDespesa(tipoDespesa: TipoDespesa) {
    // prettier-ignore
    this.tipoDespesaService.remove(tipoDespesa)
      .subscribe(() => {
        this.messageService.add({ 
          severity: 'success', summary: 'Successo', detail: 'Tipo Despesa removida com sucesso!', life: 3000 
        });
        this.loadData();
      });
  }

  editTipoDespesa(tipoDespesa: TipoMovimentacao) {
    this.router.navigate(['tipo-despesa', tipoDespesa.id]);
  }

  adicionarTipoDespesa() {
    this.router.navigate(['tipo-despesa']);
  }
}
