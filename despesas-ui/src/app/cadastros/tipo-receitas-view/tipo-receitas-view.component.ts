import { Component, ViewChild } from '@angular/core';
import { Table } from 'primeng/table';
import { TipoReceita } from '../../models/tipo-movimentacao.model';
import { TipoReceitaService } from '../../services/tipo-receita.service';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-tipo-receitas-view',
  templateUrl: './tipo-receitas-view.component.html',
  styleUrl: './tipo-receitas-view.component.scss'
})
export class TipoReceitasViewComponent {

  @ViewChild('table')
  private table?: Table;

  data: TipoReceita[] = [];
  showDialog: boolean = false;
  tipoReceitaSelecionado?: TipoReceita;
  searchValue?: string;

  constructor(private tipoReceitaService: TipoReceitaService, private messageService: MessageService) { }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {

    this.tipoReceitaService.buscarTipoReceitas().subscribe((data: TipoReceita[]) => {
      this.data = [...data];
    });

  }

  removerTipoReceita(tipoReceita: TipoReceita) {
    this.tipoReceitaSelecionado = tipoReceita;
    this.showDialog = true;
  }

  doRemoverTipoReceita() {

    if (this.tipoReceitaSelecionado) {

      this.tipoReceitaService.removerTipoReceita(this.tipoReceitaSelecionado).subscribe(() => {

        this.showDialog = false;
        this.messageService.add({ severity: 'success', summary: 'Success', detail: 'Tipo Receita removida com sucesso!' });

        this.loadData();

      });

    }

  }

  search() {
    this.table?.filterGlobal(this.searchValue, 'contains');
  }

}
