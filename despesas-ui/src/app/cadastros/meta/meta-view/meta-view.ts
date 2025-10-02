import { Component, inject, OnInit, signal, ViewChild } from '@angular/core';
import { ButtonModule } from 'primeng/button';
import { Loader } from '../../../components/loader/loader';
import { Table, TableModule } from 'primeng/table';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { FormsModule } from '@angular/forms';
import { ColorDisplay } from '../../../components/color-display/color-display';
import { CurrencyPipe, DecimalPipe } from '@angular/common';
import { DialogModule } from 'primeng/dialog';
import { Meta } from '../../../models/meta.model';
import { InputTextModule } from 'primeng/inputtext';
import { SelectMes } from '../../../components/select-mes/select-mes';
import { Mes } from '../../../models/mes.model';
import { PanelModule } from 'primeng/panel';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { MetaFiltro, MetaService } from '../../../services/meta-service';

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
    SelectMes,
    PanelModule,
    DecimalPipe,
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
  mesSelecionado: Mes = Mes.getMesAtual();
  anoSelecionado: number = new Date().getFullYear();
  mes = Mes;

  private router = inject(Router);
  private messageService = inject(MessageService);
  private metaService = inject(MetaService);

  constructor() {}

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {
    let filtro = {
      ano: this.anoSelecionado,
      mes: this.mesSelecionado.id + 1,
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

  changeMes(mes: Mes) {
    this.mesSelecionado = mes;
  }

  add() {
    this.router.navigate(['meta']);
  }

  remover() {}
  openDialog(meta: Meta) {}
  edit(meta: Meta) {}

  setToCurrentMonth() {
    this.mesSelecionado = Mes.getMesAtual();
    this.anoSelecionado = new Date().getFullYear();
  }
}
