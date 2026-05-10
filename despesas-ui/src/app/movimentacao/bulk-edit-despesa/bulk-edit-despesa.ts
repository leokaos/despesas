import { Component, inject, OnInit, signal } from '@angular/core';
import { ButtonModule } from 'primeng/button';
import { TableModule } from 'primeng/table';
import { FormsModule } from '@angular/forms';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { DatePickerModule } from 'primeng/datepicker';
import { DebitavelFiltro, DebitavelService } from '../../services/debitavel-service';
import { Debitavel } from '../../models/debitavel.model';
import { Loader } from '../../components/loader/loader';
import { SelectTipoMovimentacao } from '../../components/select-tipo-movimentacao/select-tipo-movimentacao';
import { SelectDebitavel } from '../../components/select-debitavel/select-debitavel';
import { CheckboxModule } from 'primeng/checkbox';
import { DialogModule } from "primeng/dialog";
import { MessageService } from 'primeng/api';
import { Despesa } from './../../models/movimentacao.model';
import { TipoDespesa, TipoMovimentacao } from '../../models/tipo-movimentacao.model';
import { DespesaService } from '../../services/despesa-service';
import { TipoDespesaService } from '../../services/tipo-despesa-service';
import { concatMap, finalize, forkJoin, from, tap } from 'rxjs';
import { AppProgressBar } from '../../components/app-progress-bar/app-progress-bar';

@Component({
  selector: 'app-bulk-edit-despesa',
  imports: [
    ButtonModule,
    TableModule,
    FormsModule,
    InputNumberModule,
    InputTextModule,
    DatePickerModule,
    Loader,
    SelectTipoMovimentacao,
    SelectDebitavel,
    CheckboxModule,
    DialogModule,
    AppProgressBar
  ],
  templateUrl: './bulk-edit-despesa.html',
  styleUrl: './bulk-edit-despesa.scss',
})
export class BulkEditDespesa implements OnInit {

  despesas = signal<Despesa[]>([]);
  tipos: TipoDespesa[] = [];
  debitaveis: Debitavel[] = [];

  vencimento?: Date;
  tipoDespesa?: TipoDespesa;
  debitavel?: Debitavel;

  total = signal<number>(0);
  parcial = signal<number>(0);
  visibleSave = signal<boolean>(false);

  queryText: string = "";

  private tipoDespesaService = inject(TipoDespesaService);
  private debitavelService = inject(DebitavelService);
  private despesaService = inject(DespesaService);
  private messageService = inject(MessageService);

  loading = signal<boolean>(true);
  searching = signal<boolean>(false);

  constructor() { }

  ngOnInit(): void {
    let debitavelFiltro = {
      ativo: true,
    } as DebitavelFiltro;

    forkJoin({
      tipos: this.tipoDespesaService.fetch(),
      debitaveis: this.debitavelService.fetch(debitavelFiltro),
    }).subscribe((results: any) => {
      this.tipos = results.tipos;
      this.debitaveis = results.debitaveis;
      this.loading.set(false);
    });
  }

  search() {
    if (!this.queryText.trim()) {
      this.despesas.set([]);
      return;
    }

    this.searching.set(true);

    this.despesaService.search(this.queryText)
      .pipe(finalize(() => this.searching.set(false)))
      .subscribe((despesas: Despesa[]) => {
        this.despesas.set(despesas);
      });
  }

  clear() {
    this.queryText = '';
    this.despesas.set([]);
    this.debitavel = undefined;
    this.vencimento = undefined;
    this.tipoDespesa = undefined;
    this.total.set(0);
    this.parcial.set(0);
  }

  setMoeda(despesa: Despesa) {
    despesa.moeda = despesa.debitavel?.moeda;
  }

  salvar() {
    this.total.set(this.despesas.length);
    this.parcial.set(0);

    from(this.despesas()).pipe(
      concatMap(despesa => this.despesaService.createOrUpdate(despesa, null).pipe(
        tap(() => {
          this.parcial.update(value => value + 1)
        })
      )),
      finalize(() => {

        this.visibleSave.set(false);

        if (this.parcial() === this.total()) {
          this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Despesas salvas com sucesso!' });
          this.clear();
        }

      })).subscribe({
        error: (error) => this.messageService.add({ severity: 'error', summary: 'Erro', detail: `Erro ao salvar despesas: ${error.message}` })
      });
  }

  setDebitavel($event: Debitavel | null) {
    if ($event) {
      this.despesas().forEach(d => d.debitavel = $event);
    }
  }

  setTipoDespesa($event: TipoMovimentacao) {
    if ($event) {
      this.despesas().forEach(d => d.tipo = $event);
    }
  }

  setVencimento($event: Date) {
    if ($event) {
      this.despesas().forEach(d => d.vencimento = $event);
    }
  }

  remove(despesa: Despesa) {

    this.despesaService.remove(despesa).subscribe(_ => {
      this.despesas.update(despesas => despesas.filter(d => d.id !== despesa.id));
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Despesa removida com sucesso!' });
    });

  }

}