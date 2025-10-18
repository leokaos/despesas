import { ParcelamentoVO } from './../../../models/movimentacao.model';
import { Orcamento } from './../../../models/orcamento.model';
import { CommonModule } from '@angular/common';
import { Component, inject, OnInit, signal } from '@angular/core';
import { FormsModule, ReactiveFormsModule, FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { MessageService } from 'primeng/api';
import { ButtonModule } from 'primeng/button';
import { CheckboxModule } from 'primeng/checkbox';
import { DatePickerModule } from 'primeng/datepicker';
import { InputGroupModule } from 'primeng/inputgroup';
import { InputGroupAddonModule } from 'primeng/inputgroupaddon';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { SelectModule } from 'primeng/select';
import { combineLatest, forkJoin } from 'rxjs';
import { Loader } from '../../../components/loader/loader';
import { SelectDebitavel } from '../../../components/select-debitavel/select-debitavel';
import { SelectTipoMovimentacao } from '../../../components/select-tipo-movimentacao/select-tipo-movimentacao';
import { Debitavel } from '../../../models/debitavel.model';
import { Despesa } from '../../../models/movimentacao.model';
import { TipoDespesa, TipoMovimentacao } from '../../../models/tipo-movimentacao.model';
import { DebitavelService, DebitavelFiltro } from '../../../services/debitavel-service';
import { DespesaService } from '../../../services/despesa-service';
import { TipoDespesaService } from '../../../services/tipo-despesa-service';
import { AppProgressBar } from "../../../components/app-progress-bar/app-progress-bar";
import { OrcamentoFiltro, OrcamentoService } from '../../../services/orcamento-service';
import { PeriodoUtil } from '../../../models/util';
import { Periodo } from '../../../models/periodo.model';
import { Mes } from '../../../models/mes.model';

@Component({
  selector: 'app-despesa-edit',
  imports: [
    Loader,
    FormsModule,
    ReactiveFormsModule,
    InputGroupModule,
    InputGroupAddonModule,
    InputNumberModule,
    DatePickerModule,
    CommonModule,
    SelectTipoMovimentacao,
    ButtonModule,
    InputTextModule,
    CheckboxModule,
    SelectModule,
    SelectDebitavel,
    AppProgressBar
  ],
  templateUrl: './despesa-edit.html',
  styleUrl: './despesa-edit.scss',
})
export class DespesaEdit implements OnInit {

  debitaveis: Debitavel[] = [];
  tipos: TipoDespesa[] = [];
  despesa?: Despesa;
  formGroup!: FormGroup;
  orcamento?: Orcamento;
  parcelar: boolean = false;
  tiposParcelamento: string[] = ['Semanal', 'Mensal', 'Semestral', 'Anual'];

  private router = inject(Router);
  private formBuilder = inject(FormBuilder);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);
  private despesaService = inject(DespesaService);
  private debitavelService = inject(DebitavelService);
  private tipoDespesaService = inject(TipoDespesaService);
  private orcamentoService = inject(OrcamentoService);

  loading = signal<boolean>(true);

  constructor() { }

  ngOnInit(): void {
    var id = this.activatedRoute.snapshot.paramMap.get('id');
    var filtro = { ativo: true } as DebitavelFiltro;

    var requests: any = {
      debitaveis: this.debitavelService.fetch(filtro),
      tipos: this.tipoDespesaService.fetch(),
    };

    if (id) {
      requests.despesa = this.despesaService.fetchById(parseInt(id));
    }

    forkJoin(requests).subscribe((results: any) => {
      this.debitaveis = [...results.debitaveis];
      this.tipos = [...results.tipos];

      if (results.despesa) {
        this.despesa = results.despesa;
      }

      this.buildForm();
    });
  }

  private buildForm() {
    this.formGroup = this.formBuilder.group({
      descricao: [this.despesa?.descricao, Validators.required],
      valor: [this.despesa?.valor, Validators.required],
      vencimento: [this.despesa?.vencimento, Validators.required],
      tipo: [this.despesa?.tipo, Validators.required],
      debitavel: [this.despesa?.debitavel, Validators.required],
      paga: [this.despesa?.paga || false, Validators.required],
      numeroParcelas: [null],
      tipoParcelamento: [null]
    });

    const tipoSelection$ = this.formGroup.get('tipo')?.valueChanges;
    const dateSeleciton$ = this.formGroup.get('vencimento')?.valueChanges;

    if (tipoSelection$ && dateSeleciton$) {
      combineLatest([tipoSelection$, dateSeleciton$]).subscribe(([tipo, date]) => {
        this.checkOrcamento(tipo, date);
      });
    }

    this.loading.set(false);
  }

  checkOrcamento(tipo: TipoMovimentacao, vencimento: Date) {

    if (tipo && vencimento) {

      let periodo = {
        ano: vencimento.getFullYear(),
        mes: Mes.getPorId(vencimento.getMonth())
      } as Periodo;

      let orcamentoFiltro = {
        dataInicial: PeriodoUtil.getDataInicial(periodo),
        dataFinal: PeriodoUtil.getDataFinal(periodo),
        tipo: tipo
      } as OrcamentoFiltro;

      this.orcamentoService.fetch(orcamentoFiltro).subscribe((orcamentos: Orcamento[]) => {
        if (orcamentos.length == 1) {
          this.orcamento = orcamentos[0];
        }
      });
    }
  }

  save() {
    var despesa = {
      id: this.despesa?.id,
      pagamento: this.despesa?.pagamento,
      moeda: this.formGroup.get('debitavel')?.value.moeda,
      descricao: this.formGroup.get('descricao')?.value,
      valor: this.formGroup.get('valor')?.value,
      vencimento: this.formGroup.get('vencimento')?.value,
      tipo: this.formGroup.get('tipo')?.value,
      debitavel: this.formGroup.get('debitavel')?.value,
      paga: this.formGroup.get('paga')?.value,
    } as Despesa;

    var parcelamentoVO = null;

    if (this.parcelar) {
      parcelamentoVO = {
        parcelas: this.formGroup.get('numeroParcelas')?.value,
        tipo: this.formGroup.get('tipoParcelamento')?.value
      } as ParcelamentoVO;
    }

    this.despesaService.createOrUpdate(despesa, parcelamentoVO).subscribe((_) => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Despesa salva com sucesso!', life: 3000 });
      this.returnToView();
    });
  }

  returnToView() {
    this.router.navigate(['despesas']);
  }

  cancel() {
    this.returnToView();
  }
}
