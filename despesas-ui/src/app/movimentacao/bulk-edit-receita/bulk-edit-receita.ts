import { Component, OnInit, signal, inject } from "@angular/core";
import { FormsModule } from "@angular/forms";
import { MessageService } from "primeng/api";
import { ButtonModule } from "primeng/button";
import { CheckboxModule } from "primeng/checkbox";
import { DatePickerModule } from "primeng/datepicker";
import { DialogModule } from "primeng/dialog";
import { InputNumberModule } from "primeng/inputnumber";
import { InputTextModule } from "primeng/inputtext";
import { TableModule } from "primeng/table";
import { forkJoin, finalize } from "rxjs";
import { AppSaveDialog } from "../../components/app-save-dialog/app-save-dialog";
import { Loader } from "../../components/loader/loader";
import { SelectDebitavel } from "../../components/select-debitavel/select-debitavel";
import { SelectTipoMovimentacao } from "../../components/select-tipo-movimentacao/select-tipo-movimentacao";
import { Debitavel } from "../../models/debitavel.model";
import { Receita } from "../../models/movimentacao.model";
import { TipoReceita, TipoMovimentacao } from "../../models/tipo-movimentacao.model";
import { DebitavelService, DebitavelFiltro } from "../../services/debitavel-service";
import { ReceitaService } from "../../services/receita-service";
import { TipoReceitaService } from "../../services/tipo-receita-service";
import { PanelFiltro } from "../../components/panel-filtro/panel-filtro";
import { SumPipe } from "../../pipes/sum-pipe";
import { DecimalPipe } from "@angular/common";

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
    AppSaveDialog,
    PanelFiltro,
    SumPipe,
    DecimalPipe
  ],
  templateUrl: './bulk-edit-receita.html',
  styleUrl: './bulk-edit-receita.scss',
})
export class BulkEditReceita implements OnInit {

  receitas = signal<Receita[]>([]);
  tipos: TipoReceita[] = [];
  debitaveis: Debitavel[] = [];
  selectedData: Receita[] = [];

  vencimento?: Date;
  tipoReceita?: TipoReceita;
  debitavel?: Debitavel;

  visibleSave = signal<boolean>(false);

  private tipoReceitaService = inject(TipoReceitaService);
  private debitavelService = inject(DebitavelService);
  private receitaService = inject(ReceitaService);
  private messageService = inject(MessageService);

  loading = signal<boolean>(true);
  searching = signal<boolean>(false);

  constructor() { }

  ngOnInit(): void {

    forkJoin({
      tipos: this.tipoReceitaService.fetch(),
      debitaveis: this.debitavelService.fetch(),
    }).subscribe((results: any) => {
      this.tipos = results.tipos;
      this.debitaveis = results.debitaveis;
      this.loading.set(false);
    });
  }

  search(expression: string) {
    if (!expression) {
      this.receitas.set([]);
      return;
    }

    this.debitavel = undefined;
    this.vencimento = undefined;
    this.tipoReceita = undefined;

    this.searching.set(true);

    this.receitaService.search(expression)
      .pipe(finalize(() => this.searching.set(false)))
      .subscribe((receitas: Receita[]) => {
        this.receitas.set(receitas);
      });
  }

  saveReceita(item: Receita) {
    return this.receitaService.createOrUpdate(item);
  }

  clear() {
    this.receitas.set([]);
    this.debitavel = undefined;
    this.vencimento = undefined;
    this.tipoReceita = undefined;
  }

  setMoeda(receita: Receita) {
    receita.moeda = receita.debitavel?.moeda;
  }

  setDebitavel($event: Debitavel | null) {
    if ($event) {
      this.receitas().forEach(d => d.debitavel = $event);
    }
  }

  setTiporeceita($event: TipoMovimentacao) {
    if ($event) {
      this.receitas().forEach(d => d.tipo = $event);
    }
  }

  setVencimento($event: Date) {
    if ($event) {
      this.receitas().forEach(d => d.vencimento = $event);
    }
  }

  remove(receita: Receita) {

    this.receitaService.remove(receita).subscribe(_ => {
      this.receitas.update(receitas => receitas.filter(r => r.id !== receita.id));
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Receita removida com sucesso!' });
    });

  }

}