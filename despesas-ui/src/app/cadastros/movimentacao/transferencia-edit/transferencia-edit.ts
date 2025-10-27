import { TransferenciaService } from './../../../services/transferencia-service';
import { Component, inject, signal } from '@angular/core';
import { Loader } from '../../../components/loader/loader';
import { InputGroupModule } from 'primeng/inputgroup';
import { ButtonModule } from 'primeng/button';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputGroupAddonModule } from 'primeng/inputgroupaddon';
import { ActivatedRoute, Router } from '@angular/router';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { MessageService } from 'primeng/api';
import { Transferencia } from '../../../models/movimentacao.model';
import { InputTextModule } from 'primeng/inputtext';
import { DatePickerModule } from 'primeng/datepicker';
import { DebitavelFiltro, DebitavelService } from '../../../services/debitavel-service';
import { forkJoin } from 'rxjs';
import { Debitavel } from '../../../models/debitavel.model';
import { SelectDebitavel } from '../../../components/select-debitavel/select-debitavel';

@Component({
  selector: 'app-transferencia-edit',
  imports: [
    Loader,
    InputGroupModule,
    ButtonModule,
    InputNumberModule,
    InputGroupAddonModule,
    ReactiveFormsModule,
    InputTextModule,
    DatePickerModule,
    SelectDebitavel,
  ],
  templateUrl: './transferencia-edit.html',
  styleUrl: './transferencia-edit.scss',
})
export class TransferenciaEdit {
  private router = inject(Router);
  private formBuilder = inject(FormBuilder);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);
  private transferenciaService = inject(TransferenciaService);
  private debitavelService = inject(DebitavelService);

  formGroup!: FormGroup;
  transferencia?: Transferencia;
  debitaveis: Debitavel[] = [];

  loading = signal<boolean>(true);

  constructor() { }

  ngOnInit(): void {
    var id = this.activatedRoute.snapshot.paramMap.get('id');
    var filtro = { ativo: true } as DebitavelFiltro;

    var requests: any = {
      debitaveis: this.debitavelService.fetch(filtro),
    };

    if (id) {
      requests.transferencia = this.transferenciaService.fetchById(parseInt(id));
    }

    forkJoin(requests).subscribe((results: any) => {
      this.debitaveis = [...results.debitaveis];

      if (results.transferencia) {
        this.transferencia = results.transferencia;
      }

      this.buildForm();
      this.loading.set(false);
    });
  }

  private buildForm() {
    this.formGroup = this.formBuilder.group({
      descricao: [this.transferencia?.descricao, Validators.required],
      valor: [this.transferencia?.valor, Validators.required],
      vencimento: [this.transferencia?.vencimento, Validators.required],
      debitavel: [this.transferencia?.debitavel, Validators.required],
      creditavel: [this.transferencia?.creditavel, Validators.required],
    });

    this.loading.set(false);
  }

  save() {
    var transferencia = {
      id: this.transferencia?.id,
      ...this.formGroup.value,
    };

    this.transferenciaService.createOrUpdate(transferencia).subscribe((_) => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Transferência salva com sucesso!', life: 3000 });
      this.returnToView();
    });
  }

  returnToView() {
    this.router.navigate(['transferencias']);
  }

  cancel() {
    this.returnToView();
  }
}
