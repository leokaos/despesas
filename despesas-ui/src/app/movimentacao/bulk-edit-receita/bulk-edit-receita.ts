import { Component, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MessageService } from 'primeng/api';
import { ButtonModule } from 'primeng/button';
import { CheckboxModule } from 'primeng/checkbox';
import { DatePickerModule } from 'primeng/datepicker';
import { DialogModule } from 'primeng/dialog';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { TableModule } from 'primeng/table';
import { forkJoin, from, concatMap, tap, finalize } from 'rxjs';
import { AppProgressBar } from '../../components/app-progress-bar/app-progress-bar';
import { Loader } from '../../components/loader/loader';
import { SelectDebitavel } from '../../components/select-debitavel/select-debitavel';
import { SelectTipoMovimentacao } from '../../components/select-tipo-movimentacao/select-tipo-movimentacao';
import { Debitavel } from '../../models/debitavel.model';
import { TipoMovimentacao, TipoReceita } from '../../models/tipo-movimentacao.model';
import { DebitavelService, DebitavelFiltro } from '../../services/debitavel-service';
import { Receita } from '../../models/movimentacao.model';
import { TipoReceitaService } from '../../services/tipo-receita-service';
import { ReceitaService } from '../../services/receita-service';

@Component({
  selector: 'app-bulk-edit-receita',
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
  templateUrl: './bulk-edit-receita.html',
  styleUrl: './bulk-edit-receita.scss',
})
export class BulkEditReceita {

  receitas: Receita[] = [];
  tipos: TipoReceita[] = [];
  debitaveis: Debitavel[] = [];

  vencimento?: Date;
  tipoReceita?: TipoReceita;
  debitavel?: Debitavel;

  total = signal<number>(0);
  parcial = signal<number>(0);
  visibleSave = signal<boolean>(false);

  queryText: string = "";

  private tipoReceitaService = inject(TipoReceitaService);
  private debitavelService = inject(DebitavelService);
  private receitaService = inject(ReceitaService);
  private messageService = inject(MessageService);

  loading = signal<boolean>(true);
  searching = signal<boolean>(false);

  constructor() { }

  ngOnInit(): void {
    let debitavelFiltro = {
      ativo: true,
    } as DebitavelFiltro;

    forkJoin({
      tipos: this.tipoReceitaService.fetch(),
      debitaveis: this.debitavelService.fetch(debitavelFiltro),
    }).subscribe((results: any) => {
      this.tipos = results.tipos;
      this.debitaveis = results.debitaveis;
      this.loading.set(false);
    });
  }

  search() {
    if (!this.queryText.trim()) {
      this.receitas = [];
      return;
    }

    this.searching.set(true);

    this.receitaService.search(this.queryText).subscribe((receitas: Receita[]) => {
      this.receitas = receitas;
      this.searching.set(false);
    });
  }

  clear() {
    this.queryText = '';
    this.receitas = [];
    this.debitavel = undefined;
    this.vencimento = undefined;
    this.tipoReceita = undefined;
    this.total.set(0);
    this.parcial.set(0);
  }

  setMoeda(receita: Receita) {
    receita.moeda = receita.debitavel?.moeda;
  }

  salvar() {
    this.total.set(this.receitas.length);
    this.parcial.set(0);

    from(this.receitas).pipe(
      concatMap(receita => this.receitaService.createOrUpdate(receita).pipe(
        tap(() => {
          this.parcial.update(value => value + 1)
        })
      )),
      finalize(() => {

        this.visibleSave.set(false);

        if (this.parcial() === this.total()) {
          this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Receitas salvas com sucesso!' });
          this.clear();
        }

      })).subscribe({
        error: (error) => this.messageService.add({ severity: 'error', summary: 'Erro', detail: `Erro ao salvar receitas: ${error.message}` })
      });
  }

  setDebitavel($event: Debitavel | null) {
    if ($event) {
      this.receitas.forEach(d => d.debitavel = $event);
    }
  }

  setTiporeceita($event: TipoMovimentacao) {
    if ($event) {
      this.receitas.forEach(d => d.tipo = $event);
    }
  }

  setVencimento($event: Date) {
    if ($event) {
      this.receitas.forEach(d => d.vencimento = $event);
    }
  }

}