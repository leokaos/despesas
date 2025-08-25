import { Component, EventEmitter, Input, Output, ViewChild } from '@angular/core';
import { TipoMovimentacao } from '../../../models/tipo-movimentacao.model';
import { Table, TableModule } from 'primeng/table';
import { ButtonModule } from 'primeng/button';
import { IconFieldModule } from 'primeng/iconfield';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DialogModule } from 'primeng/dialog';
import { InputIconModule } from 'primeng/inputicon';
import { ColorPickerModule } from 'primeng/colorpicker';

@Component({
  selector: 'app-tipo-view',
  imports: [ButtonModule, TableModule, IconFieldModule, FormsModule, DialogModule, InputIconModule, ReactiveFormsModule, ColorPickerModule],
  templateUrl: './tipo-view.html',
  styleUrl: './tipo-view.scss',
  standalone: true
})
export class TipoView {

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
