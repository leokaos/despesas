import { Periodo } from './../../../models/periodo.model';
import { Component, inject, OnInit, signal, ViewChild } from '@angular/core';
import { ButtonModule } from 'primeng/button';
import { Loader } from '../../../components/loader/loader';
import { Table, TableModule } from 'primeng/table';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { FormsModule } from '@angular/forms';
import { DecimalPipe, JsonPipe } from '@angular/common';
import { DialogModule } from 'primeng/dialog';
import { Meta } from '../../../models/meta.model';
import { InputTextModule } from 'primeng/inputtext';
import { Mes } from '../../../models/mes.model';
import { PanelModule } from 'primeng/panel';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { MetaFiltro, MetaService } from '../../../services/meta-service';
import { PeriodoView } from '../../../components/periodo-view/periodo-view';

@Component({
  selector: 'app-meta-view',
  imports: [
    ButtonModule,
    Loader,
    TableModule,
    IconFieldModule,
    InputIconModule,
    FormsModule,
    DialogModule,
    InputTextModule,
    PanelModule,
    DecimalPipe,
    PeriodoView,
  ],
  templateUrl: './meta-view.html',
  styleUrl: './meta-view.scss',
})
export class MetaView implements OnInit {
  @ViewChild('table')
  private table?: Table;

  loading = signal<boolean>(true);
  data: Meta[] = [];
  searchValue?: string;
  showDialog: boolean = false;
  meta?: Meta;
  periodo?: Periodo;

  private router = inject(Router);
  private messageService = inject(MessageService);
  private metaService = inject(MetaService);

  constructor() {}

  ngOnInit(): void {
    this.periodo = {
      mes: Mes.getMesAtual(),
      ano: new Date().getFullYear(),
    } as Periodo;

    this.loadData();
  }

  loadData() {
    let filtro = {
      ano: this.periodo?.ano,
      mes: (this.periodo?.mes || Mes.JANEIRO).id + 1,
    } as MetaFiltro;

    this.metaService.fetch(filtro).subscribe((data: Meta[]) => {
      this.data = [...data];
      this.loading.set(false);
    });
  }

  filter() {
    this.loading.set(true);
    this.loadData();
  }

  search() {
    this.table?.filterGlobal(this.searchValue, 'contains');
  }

  add() {
    this.router.navigate(['meta']);
  }

  remover() {
    if (this.meta) {
      // prettier-ignore
      this.metaService.remove(this.meta).subscribe(() => {
        this.messageService.add({severity: 'success', summary: 'Successo', detail: 'Meta removida com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.showDialog = false;
  }

  openDialog(meta: Meta) {
    this.showDialog = true;
    this.meta = meta;
  }

  edit(meta: Meta) {
    this.router.navigate(['meta', meta.id]);
  }
}
