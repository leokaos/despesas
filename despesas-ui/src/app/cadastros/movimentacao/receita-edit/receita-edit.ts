import { InputTextModule } from 'primeng/inputtext';
import { TipoReceitaService } from './../../../services/tipo-receita-service';
import { Component, inject, signal } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  Validators,
  ReactiveFormsModule,
} from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { MessageService } from 'primeng/api';
import { forkJoin } from 'rxjs';
import { DebitavelService, DebitavelFiltro } from '../../../services/debitavel-service';
import { ReceitaService } from '../../../services/receita-service';
import { TipoReceita } from '../../../models/tipo-movimentacao.model';
import { Debitavel } from '../../../models/debitavel.model';
import { Receita } from '../../../models/movimentacao.model';
import { Loader } from '../../../components/loader/loader';
import { InputGroupModule } from 'primeng/inputgroup';
import { InputGroupAddonModule } from 'primeng/inputgroupaddon';
import { InputNumberModule } from 'primeng/inputnumber';
import { DatePickerModule } from 'primeng/datepicker';
import { CommonModule, JsonPipe } from '@angular/common';
import { SelectDebitavel } from '../../../components/select-debitavel/select-debitavel';
import { SelectTipoMovimentacao } from '../../../components/select-tipo-movimentacao/select-tipo-movimentacao';
import { ButtonModule } from "primeng/button";
import { CheckboxModule } from 'primeng/checkbox';
import { ColorDisplay } from "../../../components/color-display/color-display";
import { SelectModule } from 'primeng/select';

@Component({
  selector: 'app-receita-edit',
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
  templateUrl: './receita-edit.html',
  styleUrl: './receita-edit.scss',
})
export class ReceitaEdit {

  debitaveis: Debitavel[] = [];
  tipos: TipoReceita[] = [];
  receita?: Receita;
  formGroup!: FormGroup;

  private router = inject(Router);
  private formBuilder = inject(FormBuilder);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);
  private receitaService = inject(ReceitaService);
  private debitavelService = inject(DebitavelService);
  private tipoReceitaService = inject(TipoReceitaService);

  loading = signal<boolean>(true);

  constructor() { }

  ngOnInit(): void {
    var id = this.activatedRoute.snapshot.paramMap.get('id');
    var filtro = { ativo: true } as DebitavelFiltro;

    var requests: any = {
      debitaveis: this.debitavelService.fetch(filtro),
      tipos: this.tipoReceitaService.fetch(),
    };

    if (id) {
      requests.receita = this.receitaService.fetchById(parseInt(id));
    }

    forkJoin(requests).subscribe((results: any) => {
      this.debitaveis = [...results.debitaveis];
      this.tipos = [...results.tipos];

      if (results.receita) {
        this.receita = results.receita;
      }

      this.buildForm();
    });
  }

  private buildForm() {
    this.formGroup = this.formBuilder.group({
      descricao: [this.receita?.descricao, Validators.required],
      valor: [this.receita?.valor, Validators.required],
      vencimento: [this.receita?.vencimento, Validators.required],
      tipo: [this.receita?.tipo, Validators.required],
      debitavel: [this.receita?.debitavel, Validators.required],
      depositado: [this.receita?.depositado, Validators.required],
    });

    this.loading.set(false);
  }

  save() {
    var receita = {
      id: this.receita?.id,
      pagamento: this.receita?.pagamento,
      moeda: this.formGroup.get('debitavel')?.value.moeda,
      ...this.formGroup.value,
    };

    this.receitaService.createOrUpdate(receita).subscribe((_) => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Transferência salva com sucesso!', life: 3000 });
      this.returnToView();
    });
  }

  returnToView() {
    this.router.navigate(['receitas']);
  }

  cancel() {
    this.returnToView();
  }
}
