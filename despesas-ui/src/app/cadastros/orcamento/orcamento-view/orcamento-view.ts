import { Periodo } from './../../../models/periodo.model';
import { Orcamento } from './../../../models/orcamento.model';
import { Component, inject, OnInit, signal, ViewChild } from '@angular/core';
import { ButtonModule } from 'primeng/button';
import { Loader } from '../../../components/loader/loader';
import { Table, TableModule } from 'primeng/table';
import { IconField } from 'primeng/iconfield';
import { InputIcon } from 'primeng/inputicon';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ColorDisplay } from '../../../components/color-display/color-display';
import { DialogModule } from 'primeng/dialog';
import { OrcamentoFiltro, OrcamentoService } from '../../../services/orcamento-service';
import { InputTextModule } from 'primeng/inputtext';
import { CommonModule, DecimalPipe } from '@angular/common';
import { ProgressBarModule } from 'primeng/progressbar';
import { AppProgressBar } from '../../../components/app-progress-bar/app-progress-bar';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { PanelModule } from 'primeng/panel';
import { Mes } from '../../../models/mes.model';
import { PeriodoView } from '../../../components/periodo-view/periodo-view';
import { PeriodoUtil } from '../../../models/util';

@Component({
  selector: 'app-orcamento-view',
  imports: [
    ButtonModule,
    Loader,
    TableModule,
    IconField,
    InputIcon,
    FormsModule,
    ColorDisplay,
    DialogModule,
    InputTextModule,
    DecimalPipe,
    ProgressBarModule,
    AppProgressBar,
    ReactiveFormsModule,
    CommonModule,
    PanelModule,
    PeriodoView,
  ],
  templateUrl: './orcamento-view.html',
  styleUrl: './orcamento-view.scss',
})
export class OrcamentoView implements OnInit {
  @ViewChild('table')
  private table?: Table;

  data: Orcamento[] = [];
  searchValue?: string;
  loading = signal<boolean>(true);
  showDialog: boolean = false;
  orcamento?: Orcamento;
  periodo?: Periodo;

  private orcamentoService = inject(OrcamentoService);
  private router = inject(Router);
  private messageService = inject(MessageService);

  constructor() {}

  ngOnInit(): void {
    this.periodo = {
      mes: Mes.getMesAtual(),
      ano: new Date().getFullYear(),
    } as Periodo;

    this.loadData();
  }

  loadData() {
    let filtro = {} as OrcamentoFiltro;

    if (this.periodo) {
      filtro.dataInicial = PeriodoUtil.getDataInicial(this.periodo);
      filtro.dataFinal = PeriodoUtil.getDataFinal(this.periodo);
    }

    this.orcamentoService.fetch(filtro).subscribe((data: Orcamento[]) => {
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

  add() {
    this.router.navigate(['orcamento']);
  }

  edit(orcamento: Orcamento) {
    this.router.navigate(['orcamento', orcamento.id]);
  }

  openDialog(orcamento: Orcamento) {
    this.orcamento = orcamento;
    this.showDialog = true;
  }

  remover() {
    if (this.orcamento) {
      // prettier-ignore
      this.orcamentoService.remove(this.orcamento).subscribe(() => {
        this.messageService.add({severity: 'success', summary: 'Successo', detail: 'Orçamento removido com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.showDialog = false;
  }
}
