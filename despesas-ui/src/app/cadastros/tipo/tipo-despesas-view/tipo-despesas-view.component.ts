import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { TipoDespesa } from '../../../models/tipo-movimentacao.model';
import { TipoDespesaService } from '../../../services/tipo-despesa.service';

@Component({
  selector: 'app-tipo-despesas-view',
  templateUrl: './tipo-despesas-view.component.html',
  styleUrl: './tipo-despesas-view.component.scss'
})
export class TipoDespesasViewComponent implements OnInit {

  data: TipoDespesa[] = [];

  constructor(private tipoDespesaService: TipoDespesaService, private messageService: MessageService) { }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {

    this.tipoDespesaService.buscarTipoDespesas().subscribe((data: TipoDespesa[]) => {
      this.data = [...data];
    });

  }

  removerTipoDespesa(tipoDespesa: TipoDespesa) {

    this.tipoDespesaService.removerTipoDespesa(tipoDespesa).subscribe(() => {
      this.messageService.add({ severity: 'success', summary: 'Success', detail: 'Tipo Despesa removida com sucesso!' });
      this.loadData();
    });

  }

}
