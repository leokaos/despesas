import { TipoMovimentacao } from './../../../models/tipo-movimentacao.model';
import { Component, EventEmitter, Input, Output, ViewChild } from '@angular/core';
import { Table, TableModule } from 'primeng/table';
import { ButtonModule } from 'primeng/button';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DialogModule } from 'primeng/dialog';
import { ColorPickerModule } from 'primeng/colorpicker';

import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { InputTextModule } from 'primeng/inputtext';

@Component({
  selector: 'app-tipo-view',
  imports: [ButtonModule, TableModule, IconFieldModule, FormsModule, DialogModule, InputIconModule, ReactiveFormsModule, ColorPickerModule, InputTextModule],
  templateUrl: './tipo-view.html',
  styleUrl: './tipo-view.scss',
  standalone: true
})
export class TipoView {

  @Input()
  titulo: string = "Tipos";

  @Input()
  data: TipoMovimentacao[] = [];

  @Input()
  loading?: boolean = false;

  @Output()
  onRemover: EventEmitter<TipoMovimentacao> = new EventEmitter<TipoMovimentacao>();

  @Output()
  onAdicionar: EventEmitter<void> = new EventEmitter<void>();

  @Output()
  onEdit: EventEmitter<TipoMovimentacao> = new EventEmitter<TipoMovimentacao>();

  @ViewChild('table')
  private table?: Table;

  searchValue?: string;
  tipoMovimentacao?: TipoMovimentacao;
  showDialog: boolean = false;

  constructor() { }

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

  emitAdicionar() {
    this.onAdicionar.emit();
  }

  emitEdit(tipoMovimentacao: TipoMovimentacao) {
    this.onEdit.emit(tipoMovimentacao);
  }

}
