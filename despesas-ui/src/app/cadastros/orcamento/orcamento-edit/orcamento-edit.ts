import { Orcamento } from './../../../models/orcamento.model';
import { OrcamentoService } from './../../../services/orcamento-service';
import { TipoDespesaService } from './../../../services/tipo-despesa-service';
import { Component, inject, OnInit, signal } from '@angular/core';
import { SelectTipoMovimentacao } from '../../../components/select-tipo-movimentacao/select-tipo-movimentacao';
import { Loader } from '../../../components/loader/loader';
import { TipoDespesa } from '../../../models/tipo-movimentacao.model';
import { PeriodoView } from '../../../components/periodo-view/periodo-view';
import { InputGroupModule } from 'primeng/inputgroup';
import { InputNumber } from 'primeng/inputnumber';
import { InputGroupAddonModule } from 'primeng/inputgroupaddon';
import { ButtonModule } from 'primeng/button';
import { ActivatedRoute, Router } from '@angular/router';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { MessageService } from 'primeng/api';
import { forkJoin } from 'rxjs';
import { PeriodoUtil } from '../../../models/util';

@Component({
  selector: 'app-orcamento-edit',
  imports: [
    SelectTipoMovimentacao,
    Loader,
    PeriodoView,
    InputGroupModule,
    InputNumber,
    InputGroupAddonModule,
    ButtonModule,
    FormsModule,
    ReactiveFormsModule,
  ],
  templateUrl: './orcamento-edit.html',
  styleUrl: './orcamento-edit.scss',
})
export class OrcamentoEdit implements OnInit {
  private tipoDespesaService = inject(TipoDespesaService);
  private router = inject(Router);
  private formBuilder = inject(FormBuilder);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);
  private orcamentoService = inject(OrcamentoService);

  loading = signal<boolean>(true);
  tiposDespesa: TipoDespesa[] = [];
  orcamento?: Orcamento;
  formGroup!: FormGroup;

  constructor() { }

  ngOnInit(): void {
    var id = this.activatedRoute.snapshot.paramMap.get('id');

    var requests: any = {
      tipos: this.tipoDespesaService.fetch(),
    };

    if (id) {
      requests.orcamento = this.orcamentoService.fetchById(parseInt(id));
    }

    forkJoin(requests).subscribe((results: any) => {
      this.tiposDespesa = [...results.tipos];

      if (results.orcamento) {
        this.orcamento = results.orcamento;
      }

      this.buildForm();
      this.loading.set(false);
    });
  }

  buildForm() {
    this.formGroup = this.formBuilder.group({
      valor: [this.orcamento?.valor || null, Validators.required],
      periodo: [this.orcamento?.periodo || null, Validators.required],
      tipo: [this.orcamento?.tipoDespesa || null, Validators.required],
    });
  }

  save() {
    let periodo = this.formGroup.get('periodo')?.getRawValue();

    var orcamento = {
      id: this.orcamento?.id,
      tipoDespesa: this.formGroup.get('tipo')?.getRawValue(),
      valor: this.formGroup.get('valor')?.getRawValue(),
      dataInicial: PeriodoUtil.getDataInicial(periodo).getTime(),
      dataFinal: PeriodoUtil.getDataFinal(periodo).getTime(),
    } as Orcamento;

    this.orcamentoService.createOrUpdate(orcamento).subscribe((_) => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Orçamento salvo com sucesso!', life: 3000 });
      this.returnToView();
    });
  }

  returnToView() {
    this.router.navigate(['orcamentos']);
  }

  cancel() {
    this.returnToView();
  }
}
