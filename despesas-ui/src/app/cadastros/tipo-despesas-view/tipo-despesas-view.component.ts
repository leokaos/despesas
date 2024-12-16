import { Component, OnInit } from '@angular/core';
import { TipoDespesa } from '../../models/tipo-movimentacao.model';
import { TipoDespesaService } from '../../services/tipo-despesa.service';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-tipo-despesas-view',
  templateUrl: './tipo-despesas-view.component.html',
  styleUrl: './tipo-despesas-view.component.scss'
})
export class TipoDespesasViewComponent implements OnInit {

  public data: TipoDespesa[] = [];
  public showDialog: boolean = false;
  public tipoDespesaSelecionado?: TipoDespesa;

  constructor(
    private tipoDespesaService: TipoDespesaService,
    private messageService: MessageService
  ) { }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {

    this.tipoDespesaService.buscarTipoDespesas().subscribe((data: TipoDespesa[]) => {
      this.data = [...data];
    });

  }

  removerTipoDespesa(tipoDespesa: TipoDespesa) {
    this.tipoDespesaSelecionado = tipoDespesa;
    this.showDialog = true;
  }

  doRemoverTipoDespesa() {

    if (this.tipoDespesaSelecionado) {

      this.tipoDespesaService.removerTipoDespesa(this.tipoDespesaSelecionado).subscribe(() => {

        this.showDialog = false;
        this.messageService.add({ severity: 'success', summary: 'Success', detail: 'Tipo Despesa removida com sucesso!' });

        this.loadData();

      });

    }

  }

}
