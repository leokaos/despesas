import { MessageService } from 'primeng/api';
import { TipoDespesaService } from './../../../services/tipo-despesa-service';
import { AfterViewInit, ChangeDetectorRef, Component, inject, OnInit } from '@angular/core';
import { TipoDespesa, TipoMovimentacao } from '../../../models/tipo-movimentacao.model';
import { TipoView } from '../tipo-view/tipo-view';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';

@Component({
  selector: 'app-tipo-despesas-view',
  imports: [TipoView, CommonModule],
  providers: [MessageService],
  templateUrl: './tipo-despesas-view.html',
  styleUrl: './tipo-despesas-view.scss',
  standalone: true
})
export class TipoDespesasView implements OnInit {

  data: TipoDespesa[] = [];
  loading: boolean = true;

  private tipoDespesaService = inject(TipoDespesaService);
  private messageService = inject(MessageService);
  private cdRef = inject(ChangeDetectorRef);
  private router = inject(Router);

  constructor() { }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {

    this.tipoDespesaService.buscarTipoDespesas().subscribe((data: TipoDespesa[]) => {
      this.data = [...data];
      this.loading = false;
      this.cdRef.detectChanges();
    });

  }

  removerTipoDespesa(tipoDespesa: TipoDespesa) {

    this.tipoDespesaService.removerTipoDespesa(tipoDespesa).subscribe(() => {
      this.messageService.add({ severity: 'success', summary: 'Success', detail: 'Tipo Despesa removida com sucesso!' });
      this.loadData();
    });

  }

  editTipoDespesa(tipoDespesa: TipoMovimentacao) {
    this.router.navigate(["tipo-despesa", tipoDespesa.id]);
  }

  adicionarTipoDespesa() {
    this.router.navigate(["tipo-despesa"]);
  }

}
