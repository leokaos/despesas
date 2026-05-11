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
import { Despesa } from "../../models/movimentacao.model";
import { TipoDespesa, TipoMovimentacao } from "../../models/tipo-movimentacao.model";
import { DebitavelService, DebitavelFiltro } from "../../services/debitavel-service";
import { DespesaService } from "../../services/despesa-service";
import { TipoDespesaService } from "../../services/tipo-despesa-service";

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
    AppSaveDialog
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

    this.debitavel = undefined;
    this.vencimento = undefined;
    this.tipoDespesa = undefined;

    this.searching.set(true);

    this.despesaService.search(this.queryText)
      .pipe(finalize(() => this.searching.set(false)))
      .subscribe((despesas: Despesa[]) => {
        this.despesas.set(despesas);
      });
  }

  saveDespesa(item: Despesa) {
    return this.despesaService.createOrUpdate(item, null);
  }

  clear() {
    this.queryText = '';
    this.despesas.set([]);
    this.debitavel = undefined;
    this.vencimento = undefined;
    this.tipoDespesa = undefined;
  }

  setMoeda(despesa: Despesa) {
    despesa.moeda = despesa.debitavel?.moeda;
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