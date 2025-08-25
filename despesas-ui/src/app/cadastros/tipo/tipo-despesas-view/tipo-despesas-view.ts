import { MessageService } from 'primeng/api';
import { TipoDespesaService } from './../../../services/tipo-despesa-service';
import { AfterViewInit, ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { TipoDespesa } from '../../../models/tipo-movimentacao.model';
import { TipoView } from '../tipo-view/tipo-view';
import { CommonModule } from '@angular/common';

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

  constructor(private tipoDespesaService: TipoDespesaService, private messageService: MessageService, private cdRef: ChangeDetectorRef) { }

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

}
