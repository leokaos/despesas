import { Component, inject, OnInit, signal, ViewChild } from '@angular/core';
import { PanelModule } from 'primeng/panel';
import { ButtonModule } from 'primeng/button';
import { DatePickerModule } from 'primeng/datepicker';
import { Loader } from '../../../components/loader/loader';
import { Table, TableModule } from 'primeng/table';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { ColorDisplay } from '../../../components/color-display/color-display';
import { DialogModule } from 'primeng/dialog';
import { ReceitaFiltro, ReceitaService } from '../../../services/receita-service';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { Receita } from '../../../models/movimentacao.model';
import { DateUtil } from '../../../models/util';
import { FormsModule } from '@angular/forms';
import { DatePipe, DecimalPipe } from '@angular/common';
import { InputTextModule } from 'primeng/inputtext';
import { SumPipe } from '../../../pipes/sum-pipe';
import { FloatLabelModule } from 'primeng/floatlabel';
import { SelectTipoMovimentacao } from "../../../components/select-tipo-movimentacao/select-tipo-movimentacao";
import { TipoReceitaService } from '../../../services/tipo-receita-service';
import { DebitavelFiltro, DebitavelService } from '../../../services/debitavel-service';
import { forkJoin } from 'rxjs';
import { TipoReceita } from '../../../models/tipo-movimentacao.model';
import { Debitavel } from '../../../models/debitavel.model';
import { AvgPipe } from '../../../pipes/avg-pipe';
import { SelectDebitavel } from "../../../components/select-debitavel/select-debitavel";

@Component({
  selector: 'app-receita-view',
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
  templateUrl: './receita-view.html',
  styleUrl: './receita-view.scss',
})
export class ReceitaView implements OnInit {

  @ViewChild('table')
  private table?: Table;

  loading = signal<boolean>(true);

  data = signal<Receita[]>([]);
  selectedData: Receita[] = [];

  tipos: TipoReceita[] = [];
  tipoSelecionado?: TipoReceita;

  debitaveis: Debitavel[] = [];
  debitavelSelecionado?: Debitavel;

  searchValue?: string;
  showDialog: boolean = false;
  receita?: Receita;
  dataInicial: Date;
  dataFinal: Date;

  private router = inject(Router);
  private messageService = inject(MessageService);
  private receitaService = inject(ReceitaService);
  private tipoReceitaService = inject(TipoReceitaService);
  private debitavelService = inject(DebitavelService);

  constructor() {
    this.dataInicial = DateUtil.getCurrentDataInicial();
    this.dataFinal = DateUtil.getCurrentDataFinal();
  }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {

    let filtroReceita = {
      dataInicial: this.dataInicial,
      dataFinal: this.dataFinal,
      tipo: this.tipoSelecionado,
      debitavel: this.debitavelSelecionado
    } as ReceitaFiltro;

    let filtroDebitavel = {
      ativo: true
    } as DebitavelFiltro;

    forkJoin({
      tipos: this.tipoReceitaService.fetch(),
      receitas: this.receitaService.fetch(filtroReceita),
      debitaveis: this.debitavelService.fetch(filtroDebitavel)
    }).subscribe((results: any) => {
      this.tipos = [...results.tipos];
      this.debitaveis = [...results.debitaveis];
      this.data.update(_ => results.receitas);
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
    this.router.navigate(['receita']);
  }

  reset() {
    this.dataInicial = DateUtil.getCurrentDataInicial();
    this.dataFinal = DateUtil.getCurrentDataFinal();
    this.tipoSelecionado = undefined;
    this.debitavelSelecionado = undefined;

    this.reload();
  }

  remover() {
    if (this.receita) {
      this.receitaService.remove(this.receita).subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Receita removida com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.showDialog = false;
  }

  openDialog(receita: Receita) {
    this.showDialog = true;
    this.receita = receita;
  }

  edit(receita: Receita) {
    this.router.navigate(['receita', receita.id]);
  }
}
