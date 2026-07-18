import { Component, input, output, signal, TemplateRef, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { SelectButtonModule } from 'primeng/selectbutton';
import { Loader } from '../loader/loader';
import { ButtonModule, ButtonSeverity } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';
import { Table, TableModule } from 'primeng/table';
import { DebitavelHeader } from '../debitavel-header/debitavel-header';
import { DataView, DataViewModule } from 'primeng/dataview';
import { NgTemplateOutlet } from '@angular/common';

@Component({
  selector: 'app-base-debitavel-view',
  imports: [
    SelectButtonModule,
    FormsModule,
    ButtonModule,
    Loader,
    DialogModule,
    TableModule,
    DataViewModule,
    DebitavelHeader,
    NgTemplateOutlet,
  ],
  templateUrl: './base-debitavel-view.html',
  styleUrl: './base-debitavel-view.scss',
})
export class BaseDebitavelView {

  titulo = input.required<string>();

  loading = input.required<boolean>();
  loadingData = input.required<boolean>();

  itemTemplate = input.required<TemplateRef<any>>();

  descricao = input<string>();
  filters = input<string[]>([]);
  data = input<any[]>([]);

  columns = input.required<ColumnConfig[]>();
  extraActions = input<ActionConfig[]>([]);

  showDialog = signal<boolean>(false);

  onAdd = output();
  onRemove = output();
  onReload = output();
  onChangeAtivos = output<boolean>();
  onEdit = output<number>();

  @ViewChild('table')
  private table?: Table;

  @ViewChild('dv')
  private dv?: DataView;

  layoutOptions = [
    { label: 'List', icon: 'pi pi-bars', value: 'list' },
    { label: 'Grid', icon: 'pi pi-th-large', value: 'grid' },
  ];

  selectedLayout = signal<string>('grid');

  constructor() { }

  add() {
    this.onAdd.emit();
  }

  remove() {
    this.onRemove.emit();
  }

  search($event: string) {
    if (this.table) {
      this.table.filterGlobal($event, 'contains');
    }

    if (this.dv) {
      this.dv.filter($event, 'contains');
    }
  }

  reload() {
    this.onReload.emit();
  }

  edit(id: number) {
    this.onEdit.emit(id);
  }

}

export interface ColumnConfig {
  name: string,
  field: string,
  small?: boolean,
  center?: boolean,
  template?: TemplateRef<any>;
}

export interface ActionConfig {
  icon: string;
  severity?: ButtonSeverity;
  action: (item: any) => void;
}