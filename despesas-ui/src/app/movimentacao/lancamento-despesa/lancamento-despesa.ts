import { Component, inject, OnInit, signal } from '@angular/core';
import { ButtonModule } from 'primeng/button';
import { TableModule } from 'primeng/table';
import { SumPipe } from '../../pipes/sum-pipe';
import { DecimalPipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { DatePickerModule } from 'primeng/datepicker';
import { concatMap, finalize, forkJoin, from, map, tap } from 'rxjs';
import { DebitavelFiltro, DebitavelService } from '../../services/debitavel-service';
import { Debitavel } from '../../models/debitavel.model';
import { Loader } from '../../components/loader/loader';
import { SelectTipoMovimentacao } from '../../components/select-tipo-movimentacao/select-tipo-movimentacao';
import { SelectDebitavel } from '../../components/select-debitavel/select-debitavel';
import { CheckboxChangeEvent, CheckboxModule } from 'primeng/checkbox';
import { DialogModule } from "primeng/dialog";
import { FileUploadModule } from 'primeng/fileupload';
import { AppProgressBar } from "../../components/app-progress-bar/app-progress-bar";
import { MessageService } from 'primeng/api';
import { Despesa } from './../../models/movimentacao.model';
import { TipoDespesa } from '../../models/tipo-movimentacao.model';
import { DespesaService } from '../../services/despesa-service';
import { TipoDespesaService } from '../../services/tipo-despesa-service';

@Component({
  selector: 'app-lancamento-despesa',
  imports: [
    ButtonModule,
    TableModule,
    SumPipe,
    DecimalPipe,
    FormsModule,
    InputNumberModule,
    InputTextModule,
    DatePickerModule,
    Loader,
    SelectTipoMovimentacao,
    SelectDebitavel,
    CheckboxModule,
    DialogModule,
    FileUploadModule,
    AppProgressBar
  ],
  templateUrl: './lancamento-despesa.html',
  styleUrl: './lancamento-despesa.scss',
})
export class LancamentoDespesa implements OnInit {

  despesas: Despesa[] = [];
  tipos: TipoDespesa[] = [];
  debitaveis: Debitavel[] = [];

  selectedFile: File | null = null;

  private tipoDespesaService = inject(TipoDespesaService);
  private debitavelService = inject(DebitavelService);
  private despesaService = inject(DespesaService);
  private messageService = inject(MessageService);

  loading = signal<boolean>(true);
  visible = signal<boolean>(false);
  loadingUpload = signal<boolean>(false);
  visibleSave = signal<boolean>(false);

  debitavelSelecionado?: Debitavel;
  despesasPagas: boolean = false;

  total = signal<number>(0);
  parcial = signal<number>(0);

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

  add() {
    this.despesas.push({
      debitavel: this.debitavelSelecionado,
      moeda: this.debitavelSelecionado?.moeda
    } as Despesa);
  }

  remover(index: number) {
    this.despesas.splice(index, 1);
  }

  setDebitavel(debitavel: Debitavel | null) {
    if (debitavel) {
      this.despesas.forEach(item => {
        item.debitavel = debitavel;
        item.moeda = debitavel.moeda;
      });
    }
  }

  setPaga(event: CheckboxChangeEvent) {
    this.despesas.forEach(item => item.paga = !!event.checked);
  }

  onFileSelect(event: any) {
    if (event.files && event.files.length > 0) {
      this.selectedFile = event.files[0];
    }
  }

  upload() {

    this.loadingUpload.set(true);

    this.despesaService.uploadFile(this.selectedFile!)
      .pipe(map((despesas: Despesa[]) => despesas.map((despesa: Despesa) => this.configDespesa(despesa))))
      .subscribe((data: Despesa[]) => {
        this.despesas = [...data];
        this.visible.set(false);
      });
  }

  configDespesa(despesa: Despesa): any {
    return {
      ...despesa,
      moeda: this.debitavelSelecionado?.moeda,
      debitavel: this.debitavelSelecionado,
      paga: this.despesasPagas
    } as Despesa;
  }

  save() {
    this.total.set(this.despesas.length);
    this.parcial.set(0);

    from(this.despesas).pipe(
      concatMap(despesa => this.despesaService.createOrUpdate(despesa).pipe(
        tap(() => {
          this.parcial.update(value => value + 1)
        })
      )),
      finalize(() => {

        this.visibleSave.set(false);

        if (this.parcial() === this.total()) {

          this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Despesas salvas com sucesso!' });

          this.despesas = [];
          this.debitavelSelecionado = undefined;
          this.despesasPagas = false;
          this.total.set(0);
          this.parcial.set(0);
        }
      })).subscribe({
        error: (error) => this.messageService.add({ severity: 'error', summary: 'Erro', detail: `Erro ao salvar despesas: ${error.message}` })
      });

  }

  isAllDespesasValids(): boolean {
    return this.despesas &&
      this.despesas.length > 0 &&
      !this.despesas.find(despesa => !(despesa.debitavel && despesa.descricao && despesa.valor && despesa.tipo && despesa.debitavel && despesa.moeda));
  }

  setMoeda(despesa: Despesa) {
    despesa.moeda = despesa.debitavel?.moeda;
  }

}
