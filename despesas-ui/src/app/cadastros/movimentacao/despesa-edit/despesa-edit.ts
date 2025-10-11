import { CommonModule } from '@angular/common';
import { Component, inject, OnInit, signal } from '@angular/core';
import {
  FormsModule,
  ReactiveFormsModule,
  FormGroup,
  FormBuilder,
  Validators,
} from '@angular/forms';
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
import { forkJoin } from 'rxjs';
import { Loader } from '../../../components/loader/loader';
import { SelectDebitavel } from '../../../components/select-debitavel/select-debitavel';
import { SelectTipoMovimentacao } from '../../../components/select-tipo-movimentacao/select-tipo-movimentacao';
import { Debitavel } from '../../../models/debitavel.model';
import { Despesa, Receita } from '../../../models/movimentacao.model';
import { TipoDespesa, TipoReceita } from '../../../models/tipo-movimentacao.model';
import { DebitavelService, DebitavelFiltro } from '../../../services/debitavel-service';
import { ReceitaService } from '../../../services/receita-service';
import { TipoReceitaService } from '../../../services/tipo-receita-service';
import { DespesaService } from '../../../services/despesa-service';
import { TipoDespesaService } from '../../../services/tipo-despesa-service';

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
  ],
  templateUrl: './despesa-edit.html',
  styleUrl: './despesa-edit.scss',
})
export class DespesaEdit implements OnInit {

  debitaveis: Debitavel[] = [];
  tipos: TipoDespesa[] = [];
  despesa?: Despesa;
  formGroup!: FormGroup;

  private router = inject(Router);
  private formBuilder = inject(FormBuilder);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);
  private despesaService = inject(DespesaService);
  private debitavelService = inject(DebitavelService);
  private tipoDespesaService = inject(TipoDespesaService);

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
      paga: [this.despesa?.paga, Validators.required],
    });

    this.loading.set(false);
  }

  save() {
    var receita = {
      id: this.despesa?.id,
      pagamento: this.despesa?.pagamento,
      moeda: this.formGroup.get('debitavel')?.value.moeda,
      ...this.formGroup.value,
    };

    this.despesaService.createOrUpdate(receita).subscribe((_) => {
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
