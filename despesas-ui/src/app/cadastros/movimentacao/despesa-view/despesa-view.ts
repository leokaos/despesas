import { DatePipe, DecimalPipe } from '@angular/common';
import { Component, inject, OnInit, signal, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { ButtonModule } from 'primeng/button';
import { DatePickerModule } from 'primeng/datepicker';
import { DialogModule } from 'primeng/dialog';
import { FloatLabelModule } from 'primeng/floatlabel';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { InputTextModule } from 'primeng/inputtext';
import { PanelModule } from 'primeng/panel';
import { TableModule, Table } from 'primeng/table';
import { forkJoin } from 'rxjs';
import { ColorDisplay } from '../../../components/color-display/color-display';
import { Loader } from '../../../components/loader/loader';
import { SelectDebitavel } from '../../../components/select-debitavel/select-debitavel';
import { SelectTipoMovimentacao } from '../../../components/select-tipo-movimentacao/select-tipo-movimentacao';
import { Debitavel } from '../../../models/debitavel.model';
import { Despesa } from '../../../models/movimentacao.model';
import { TipoDespesa } from '../../../models/tipo-movimentacao.model';
import { DateUtil } from '../../../models/util';
import { AvgPipe } from '../../../pipes/avg-pipe';
import { SumPipe } from '../../../pipes/sum-pipe';
import { DebitavelService, DebitavelFiltro } from '../../../services/debitavel-service';
import { DespesaFiltro, DespesaService } from '../../../services/despesa-service';
import { TipoDespesaService } from '../../../services/tipo-despesa-service';

@Component({
  selector: 'app-despesa-view',
  imports: [
    PanelModule,
    ButtonModule,
    DatePickerModule,
    Loader,
    TableModule,
    IconFieldModule,
    InputIconModule,
    ColorDisplay,
    DialogModule,
    FormsModule,
    DatePipe,
    DecimalPipe,
    InputTextModule,
    FloatLabelModule,
    SumPipe,
    SelectTipoMovimentacao,
    AvgPipe,
    SelectDebitavel
  ],
  templateUrl: './despesa-view.html',
  styleUrl: './despesa-view.scss'
})
export class DespesaView implements OnInit {

  @ViewChild('table')
  private table?: Table;

  loading = signal<boolean>(true);

  data: Despesa[] = [];
  selectedData: Despesa[] = [];

  tipos: TipoDespesa[] = [];
  tipoSelecionado?: TipoDespesa;

  debitaveis: Debitavel[] = [];
  debitavelSelecionado?: Debitavel;

  searchValue?: string;
  showDialog: boolean = false;
  despesa?: Despesa;
  dataInicial: Date;
  dataFinal: Date;

  private router = inject(Router);
  private messageService = inject(MessageService);
  private despesaService = inject(DespesaService);
  private tipoDespesaService = inject(TipoDespesaService);
  private debitavelService = inject(DebitavelService);

  constructor() {
    this.dataInicial = DateUtil.getCurrentDataInicial();
    this.dataFinal = DateUtil.getCurrentDataFinal();
  }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {

    let filtroDespesa = {
      dataInicial: this.dataInicial,
      dataFinal: this.dataFinal,
      tipo: this.tipoSelecionado,
      debitavel: this.debitavelSelecionado
    } as DespesaFiltro;

    let filtroDebitavel = {
      ativo: true
    } as DebitavelFiltro;

    forkJoin({
      tipos: this.tipoDespesaService.fetch(),
      receitas: this.despesaService.fetch(filtroDespesa),
      debitaveis: this.debitavelService.fetch(filtroDebitavel)
    }).subscribe((results: any) => {
      this.tipos = [...results.tipos];
      this.debitaveis = [...results.debitaveis];
      this.data = [...results.receitas];
      this.selectedData = [];
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
    this.router.navigate(['despesa']);
  }

  reset() {
    this.dataInicial = DateUtil.getCurrentDataInicial();
    this.dataFinal = DateUtil.getCurrentDataFinal();
    this.tipoSelecionado = undefined;
    this.debitavelSelecionado = undefined;

    this.reload();
  }

  remover() {
    if (this.despesa) {
      this.despesaService.remove(this.despesa).subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Despesa removida com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.showDialog = false;
  }

  openDialog(despesa: Despesa) {
    this.showDialog = true;
    this.despesa = despesa;
  }

  edit(despesa: Despesa) {
    this.router.navigate(['despesa', despesa.id]);
  }
}
