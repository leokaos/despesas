import { FormsModule } from '@angular/forms';
import {
  TransferenciaFiltro,
  TransferenciaService,
} from './../../../services/transferencia-service';
import { Component, inject, OnInit, signal, ViewChild } from '@angular/core';
import { PanelModule } from 'primeng/panel';
import { ButtonModule } from 'primeng/button';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { Table, TableModule } from 'primeng/table';
import { Transferencia } from '../../../models/movimentacao.model';
import { Loader } from '../../../components/loader/loader';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { Dialog } from 'primeng/dialog';
import { DatePickerModule } from 'primeng/datepicker';
import { InputTextModule } from 'primeng/inputtext';
import { DateUtil } from '../../../models/util';
import { DatePipe, DecimalPipe } from '@angular/common';
import { ColorDisplay } from '../../../components/color-display/color-display';
import { InputNumberModule } from 'primeng/inputnumber';
import { FloatLabelModule } from "primeng/floatlabel";

@Component({
  selector: 'app-transferencia-view',
  imports: [
    PanelModule,
    ButtonModule,
    Loader,
    TableModule,
    IconFieldModule,
    InputIconModule,
    FormsModule,
    Dialog,
    DatePickerModule,
    InputTextModule,
    DecimalPipe,
    ColorDisplay,
    InputNumberModule,
    DatePipe,
    FloatLabelModule,
  ],
  templateUrl: './transferencia-view.html',
  styleUrl: './transferencia-view.scss',
})
export class TransferenciaView implements OnInit {
  @ViewChild('table')
  private table?: Table;

  loading = signal<boolean>(true);
  data: Transferencia[] = [];
  searchValue?: string;
  showDialog: boolean = false;
  transferencia?: Transferencia;
  dataInicial: Date;
  dataFinal: Date;

  private router = inject(Router);
  private messageService = inject(MessageService);
  private transferenciaService = inject(TransferenciaService);

  constructor() {
    this.dataInicial = DateUtil.getCurrentDataInicial();
    this.dataFinal = DateUtil.getCurrentDataFinal();
  }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {
    let filtro = {
      dataInicial: this.dataInicial,
      dataFinal: this.dataFinal,
    } as TransferenciaFiltro;

    this.transferenciaService.fetch(filtro).subscribe((data: Transferencia[]) => {
      this.data = [...data];
      this.loading.set(false);
    });
  }

  reload() {
    this.loading.set(true);
    this.loadData();
  }

  filter() {
    this.loading.set(true);
    this.loadData();
  }

  search() {
    this.table?.filterGlobal(this.searchValue, 'contains');
  }

  reset() {
    this.dataInicial = DateUtil.getCurrentDataInicial();
    this.dataFinal = DateUtil.getCurrentDataFinal();

    this.reload();
  }

  add() {
    this.router.navigate(['transferencia']);
  }

  remover() {
    if (this.transferencia) {
      // prettier-ignore
      this.transferenciaService.remove(this.transferencia).subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Transferência removida com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.showDialog = false;
  }

  openDialog(transferencia: Transferencia) {
    this.showDialog = true;
    this.transferencia = transferencia;
  }

  edit(transferencia: Transferencia) {
    this.router.navigate(['transferencia', transferencia.id]);
  }
}
