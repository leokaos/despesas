import { TipoReceitaService } from './../../services/tipo-receita-service';
import { Periodo } from './../../models/periodo.model';
import { Component, inject, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TableModule } from 'primeng/table';
import { InputNumberModule } from 'primeng/inputnumber';
import { FormsModule } from '@angular/forms';
import { Loader } from '../../components/loader/loader';
import { ButtonModule } from 'primeng/button';
import { PeriodoView } from '../../components/periodo-view/periodo-view';
import { ReceitaRecibo } from '../../models/recibos.model';
import { ParametroService } from '../../services/parametro-service';
import { FeriadoFiltro, FeriadoService } from '../../services/feriado-service';
import { forkJoin } from 'rxjs';
import { DialogModule } from 'primeng/dialog';
import { Debitavel } from '../../models/debitavel.model';
import { SelectDebitavel } from '../../components/select-debitavel/select-debitavel';
import { DebitavelFiltro, DebitavelService } from '../../services/debitavel-service';
import { Receita } from '../../models/movimentacao.model';
import { TipoReceita } from '../../models/tipo-movimentacao.model';
import { SelectTipoMovimentacao } from '../../components/select-tipo-movimentacao/select-tipo-movimentacao';
import { ReceitaService } from '../../services/receita-service';
import { MessageService } from 'primeng/api';
import { PeriodoUtil } from '../../models/util';
import { Feriado } from '../../models/feriado.model';

@Component({
  selector: 'app-calculo-recibos-verdes',
  imports: [
    CommonModule,
    TableModule,
    InputNumberModule,
    FormsModule,
    Loader,
    ButtonModule,
    PeriodoView,
    DialogModule,
    SelectDebitavel,
    SelectTipoMovimentacao,
  ],
  templateUrl: './calculo-recibos-verdes.html',
  styleUrl: './calculo-recibos-verdes.scss',
})
export class CalculoRecibosVerdes implements OnInit {

  loading = signal<boolean>(true);
  visible = signal<boolean>(false);
  loadingSalvar = signal<boolean>(false);

  items = signal<ReceitaRecibo[]>([]);
  feriados = signal<Feriado[]>([]);
  valorDiario = signal<number>(0);
  percentIVA = signal<number>(0);
  percentIRS = signal<number>(0);

  debitaveis: Debitavel[] = [];
  tiposReceita: TipoReceita[] = [];

  debitavelSelecionado?: Debitavel;
  tipoReceitaLiquida?: TipoReceita;
  tipoReceitaIVA?: TipoReceita;

  periodo?: Periodo;
  receitaReciboSelecionada?: ReceitaRecibo;

  private parametroService = inject(ParametroService);
  private feriadoService = inject(FeriadoService);
  private debitavelService = inject(DebitavelService);
  private tipoReceitaService = inject(TipoReceitaService);
  private receitaService = inject(ReceitaService);
  private messageService = inject(MessageService);

  constructor() { }

  ngOnInit() {

    let debitavelFiltro = { ativo: true } as DebitavelFiltro;

    forkJoin({
      valorDiario: this.parametroService.fetchValorDiario(),
      percentIVA: this.parametroService.fetchPercentIVA(),
      percentIRS: this.parametroService.fetchPercentIRS(),
      debitaveis: this.debitavelService.fetch(debitavelFiltro),
      tiposReceita: this.tipoReceitaService.fetch(),
    }).subscribe((results: any) => {
      this.valorDiario.set(results.valorDiario);
      this.percentIVA.set(results.percentIVA);
      this.percentIRS.set(results.percentIRS);
      this.debitaveis = results.debitaveis;
      this.tiposReceita = results.tiposReceita;

      this.loading.set(false);
    });

  }

  adicionarItem() {

    let filtro = {
      dataInicial: PeriodoUtil.getDataInicial(this.periodo!),
      dataFinal: PeriodoUtil.getDataFinal(this.periodo!),
    } as FeriadoFiltro;

    this.feriadoService.fetch(filtro).subscribe((data: Feriado[]) => {

      let filteredData = data.filter(feriado => !this.feriados().some(existing => existing.id === feriado.id));

      this.feriados.update(feriados => [...feriados, ...filteredData]);

      let item = new ReceitaRecibo(
        this.periodo!,
        this.valorDiario(),
        this.percentIVA(),
        this.percentIRS(),
        data,
      );

      this.items.update(items => [...items, item]);
    });

  }

  setValor() {
    this.items().forEach((item) => item.valorDiario.set(this.valorDiario()));
  }

  getTotalLiquido(): number {
    return this.items().reduce((total, item) => total + item.valorLiquido(), 0);
  }

  getTotalIVA(): number {
    return this.items().reduce((total, item) => total + item.valorIVA(), 0);
  }

  getTotalValorBruto(): string | number {
    return this.items().reduce((total, item) => total + item.valorBruto(), 0);
  }

  openDialog(receitaRecibo: ReceitaRecibo) {
    this.receitaReciboSelecionada = receitaRecibo;
    this.visible.set(true);
  }

  removeItem(receitaRecibo: ReceitaRecibo) {
    this.items.update(items => items.filter(item => item.periodo !== receitaRecibo.periodo));
  }

  salvar() {

    this.loadingSalvar.set(true);

    let receitaLiquida = {
      tipo: this.tipoReceitaLiquida,
      descricao: `Salário de ${this.receitaReciboSelecionada?.periodo.mes.name}/${this.receitaReciboSelecionada?.periodo.ano}`,
      debitavel: this.debitavelSelecionado,
      valor: this.receitaReciboSelecionada?.valorLiquido(),
      vencimento: this.receitaReciboSelecionada?.dataFinal(),
      depositado: false,
      compromissada: false,
      moeda: this.debitavelSelecionado?.moeda,
    } as Receita;

    let receitaIVA = {
      tipo: this.tipoReceitaIVA,
      descricao: `Valor IVA de ${this.receitaReciboSelecionada?.periodo.mes.name}/${this.receitaReciboSelecionada?.periodo.ano}`,
      debitavel: this.debitavelSelecionado,
      valor: this.receitaReciboSelecionada?.valorIVA(),
      vencimento: this.receitaReciboSelecionada?.dataFinal(),
      depositado: false,
      compromissada: true,
      moeda: this.debitavelSelecionado?.moeda,
    } as Receita;

    forkJoin({
      receitaLiquida: this.receitaService.createOrUpdate(receitaLiquida),
      receitaIVA: this.receitaService.createOrUpdate(receitaIVA),
    }).subscribe((_: any) => {
      this.messageService.add({
        severity: 'success',
        summary: 'Sucesso',
        detail: 'Receitas criadas com sucesso!',
        life: 3000,
      });
      this.loadingSalvar.set(false);
      this.visible.set(false);

      this.items.update(items => items.filter(item => item.periodo.mes !== this.receitaReciboSelecionada?.periodo.mes && item.periodo.ano !== this.receitaReciboSelecionada?.periodo.ano));
    });

  }

  isPeriodoAlreadyInTable(): boolean {
    return !this.periodo || this.items().some(receitaRecibo => receitaRecibo.periodo.mes == this.periodo?.mes && receitaRecibo.periodo.ano == this.periodo?.ano);
  }
}
