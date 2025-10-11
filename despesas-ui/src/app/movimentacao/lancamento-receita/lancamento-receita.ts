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
import { Receita } from '../../models/movimentacao.model';
import { TipoReceita } from '../../models/tipo-movimentacao.model';
import { ReceitaService } from '../../services/receita-service';
import { TipoReceitaService } from '../../services/tipo-receita-service';

@Component({
  selector: 'app-lancamento-receita',
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
  templateUrl: './lancamento-receita.html',
  styleUrl: './lancamento-receita.scss'
})
export class LancamentoReceita implements OnInit {

  receitas: Receita[] = [];
  tipos: TipoReceita[] = [];
  debitaveis: Debitavel[] = [];

  selectedFile: File | null = null;

  private tipoReceitaService = inject(TipoReceitaService);
  private debitavelService = inject(DebitavelService);
  private receitaService = inject(ReceitaService);
  private messageService = inject(MessageService);

  loading = signal<boolean>(true);
  visible = signal<boolean>(false);
  loadingUpload = signal<boolean>(false);
  visibleSave = signal<boolean>(false);

  debitavelSelecionado?: Debitavel;
  receitasDepositadas: boolean = false;

  total = signal<number>(0);
  parcial = signal<number>(0);

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

  add() {
    this.receitas.push({
      debitavel: this.debitavelSelecionado,
      moeda: this.debitavelSelecionado?.moeda
    } as Receita);
  }

  remover(index: number) {
    this.receitas.splice(index, 1);
  }

  setDebitavel(debitavel: Debitavel | null) {
    if (debitavel) {
      this.receitas.forEach(item => {
        item.debitavel = debitavel;
        item.moeda = debitavel.moeda;
      });
    }
  }

  setPaga(event: CheckboxChangeEvent) {
    this.receitas.forEach(item => item.depositado = !!event.checked);
  }

  onFileSelect(event: any) {
    if (event.files && event.files.length > 0) {
      this.selectedFile = event.files[0];
    }
  }

  upload() {

    this.loadingUpload.set(true);

    this.receitaService.uploadFile(this.selectedFile!)
      .pipe(map((receitas: Receita[]) => receitas.map((receita: Receita) => this.configReceita(receita))))
      .subscribe((data: Receita[]) => {
        this.receitas = [...data];
        this.visible.set(false);
      });
  }

  configReceita(receita: Receita): any {
    return {
      ...receita,
      moeda: this.debitavelSelecionado?.moeda,
      debitavel: this.debitavelSelecionado,
      depositado: this.receitasDepositadas
    } as Receita;
  }

  save() {
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

          this.receitas = [];
          this.debitavelSelecionado = undefined;
          this.receitasDepositadas = false;
          this.total.set(0);
          this.parcial.set(0);
        }
      })).subscribe({
        error: (error) => this.messageService.add({ severity: 'error', summary: 'Erro', detail: `Erro ao salvar receita: ${error.message}` })
      });

  }

  isAllReceitasValids(): boolean {
    return this.receitas &&
      this.receitas.length > 0 &&
      !this.receitas.find(receita => !(receita.debitavel && receita.descricao && receita.valor && receita.tipo && receita.debitavel && receita.moeda));
  }

  setMoeda(receita: Receita) {
    receita.moeda = receita.debitavel?.moeda;
  }

}
