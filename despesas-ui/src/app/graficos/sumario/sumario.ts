import { Despesa, Movimentacao, Receita } from './../../models/movimentacao.model';
import { Component, inject, signal } from '@angular/core';
import { PanelModule } from 'primeng/panel';
import { DatePickerModule } from 'primeng/datepicker';
import { SelectInterval } from '../../components/select-interval/select-interval';
import { ButtonModule } from 'primeng/button';
import { Interval } from '../../models/interval.model';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SelectMoeda } from '../../components/select-moeda/select-moeda';
import { Moeda } from '../../models/debitavel.model';
import { DespesaFiltro, DespesaService } from '../../services/despesa-service';
import { ReceitaFiltro, ReceitaService } from '../../services/receita-service';
import { forkJoin } from 'rxjs';
import { Loader } from '../../components/loader/loader';
import { Table, TableModule } from 'primeng/table';
import { CommonModule, DecimalPipe } from '@angular/common';
import { CardModule } from 'primeng/card';
import { DialogModule } from 'primeng/dialog';
import { DividerModule } from 'primeng/divider';
import { InputGroupModule } from 'primeng/inputgroup';
import { InputGroupAddonModule } from 'primeng/inputgroupaddon';
import { InputNumberModule } from 'primeng/inputnumber';

@Component({
  selector: 'app-sumario',
  imports: [
    PanelModule,
    DatePickerModule,
    SelectInterval,
    DecimalPipe,
    ButtonModule,
    DividerModule,
    InputGroupModule,
    InputNumberModule,
    InputGroupAddonModule,
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    Loader,
    DialogModule,
    TableModule,
    SelectMoeda,
    CardModule,
  ],
  templateUrl: './sumario.html',
  styleUrl: './sumario.scss',
})
export class Sumario {

  dataInicial?: Date;
  dataFinal?: Date;
  moeda?: Moeda;

  meses?: string[] = [];
  despesas?: Despesa[] = [];
  receitas?: Receita[] = [];
  tiposDespesa?: string[] = [];

  primeiraVez: boolean = true;

  loading = signal<boolean>(false);

  private despesaService = inject(DespesaService);
  private receitaService = inject(ReceitaService);

  constructor() { }

  setDates(interval: Interval) {
    this.dataInicial = interval.getDataInicial();
    this.dataFinal = interval.getDataFinal();
  }

  setMoeda(moeda: Moeda) {
    this.moeda = moeda;
  }

  generate() {
    this.loading.set(true);

    let despesaFiltro = { dataInicial: this.dataInicial, dataFinal: this.dataFinal, moeda: this.moeda, } as DespesaFiltro;
    let receitaFiltro = { dataInicial: this.dataInicial, dataFinal: this.dataFinal, moeda: this.moeda, } as ReceitaFiltro;

    forkJoin({
      despesas: this.despesaService.fetch(despesaFiltro),
      receitas: this.receitaService.fetch(receitaFiltro),
    }).subscribe((results: any) => {
      this.primeiraVez = false;

      this.receitas = results.receitas;
      this.despesas = results.despesas;

      this.meses = this.createMeses();
      this.tiposDespesa = this.createTipos();

      this.loading.set(false);
    });
  }

  createMeses(): string[] {
    const meses: string[] = [];

    if (this.dataInicial && this.dataFinal) {
      let dataAtual = new Date(this.dataInicial);
      dataAtual.setDate(1);

      while (dataAtual <= this.dataFinal) {
        const mes = (dataAtual.getMonth() + 1).toString().padStart(2, '0');
        const ano = dataAtual.getFullYear();

        meses.push(`${mes}/${ano}`);

        dataAtual.setMonth(dataAtual.getMonth() + 1);
      }
    }

    return meses;
  }

  createTipos(): string[] {
    return [...new Set(this.despesas?.map((despesa) => despesa.tipo.descricao))].sort();
  }

  private filterByMesAno(mes: string, movimentacao: Movimentacao[] | undefined): Movimentacao[] {

    if (!movimentacao) {
      return [];
    }

    let datas = mes.split("/");
    let parteMes = parseInt(datas[0]);
    let parteAno = parseInt(datas[1]);

    return movimentacao.filter((despesa: any) => despesa.vencimento.getFullYear() === parteAno && despesa.vencimento.getMonth() + 1 === parteMes);
  }

  getTotal(tipo: string, mes: string): number {

    let despesasFiltrada = this.filterByMesAno(mes, this.despesas).filter((despesa: any) => despesa.tipo.descricao == tipo);

    return despesasFiltrada ? despesasFiltrada.reduce((total, item) => total + item.valor, 0) : 0;
  }

  getTotalDespesas(mes: string): number {
    return this.filterByMesAno(mes, this.despesas).reduce((total, item) => total + item.valor, 0);
  }

  getTotalReceitas(mes: string): number {
    return this.filterByMesAno(mes, this.receitas).reduce((total, item) => total + item.valor, 0);
  }
}
