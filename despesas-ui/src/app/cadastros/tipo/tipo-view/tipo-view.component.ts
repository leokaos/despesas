import { Component, EventEmitter, Input, Output, ViewChild } from '@angular/core';
import { TipoMovimentacao } from '../../../models/tipo-movimentacao.model';
import { Table } from 'primeng/table';

@Component({
  selector: 'app-tipo-view',
  templateUrl: './tipo-view.component.html',
  styleUrl: './tipo-view.component.scss'
})
export class TipoViewComponent {

  @Input()
  titulo: string = "Tipos";

  @Input()
  data: TipoMovimentacao[] = [];

  @Output()
  onRemover: EventEmitter<TipoMovimentacao> = new EventEmitter<TipoMovimentacao>();

  @ViewChild('table')
  private table?: Table;

  searchValue?: string;
  tipoMovimentacao?: TipoMovimentacao;
  showDialog: boolean = false;

  constructor() {

  }

  search() {
    this.table?.filterGlobal(this.searchValue, 'contains');
  }

  openDialog(tipoMovimentacao: TipoMovimentacao) {
    this.showDialog = true;
    this.tipoMovimentacao = tipoMovimentacao;
  }

  remover() {
    this.showDialog = false
    this.onRemover.emit(this.tipoMovimentacao);
  }

}
